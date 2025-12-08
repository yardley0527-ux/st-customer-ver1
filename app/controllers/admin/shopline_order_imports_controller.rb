# app/controllers/admin/shopline_order_imports_controller.rb
class Admin::ShoplineOrderImportsController < ApplicationController  
  def new
    # 顯示上傳表單
  end
  
  def create
    if params[:file].blank?
      flash[:alert] = "請選擇要上傳的檔案"
      redirect_to new_admin_shopline_order_import_path
      return
    end

    file = params[:file]
    extension = File.extname(file.original_filename).downcase.gsub('.', '')

    begin
      # 解析 Excel / CSV 檔案
      spreadsheet = case extension
                    when 'xls'
                      Roo::Excel.new(file.path)
                    when 'xlsx'
                      Roo::Excelx.new(file.path)
                    when 'csv'
                      Roo::CSV.new(file.path, csv_options: { encoding: 'bom|utf-8' })
                    else
                      raise "不支援的檔案格式: #{extension}"
                    end

      sheet = spreadsheet.sheet(0)
      headers = sheet.row(1).map(&:to_s).map(&:strip)

      success_count = 0
      error_list = []

      # 修改：使用批次處理並進行小型事務
      (2..sheet.last_row).each do |i|
        begin
          # 每條記錄使用獨立的事務，避免一條錯誤導致全部回滾
          ActiveRecord::Base.transaction do
            row = sheet.row(i)
            data = Hash[headers.zip(row)]

            # 跳過整行都是空值的 row
            next if row.compact.blank?

            # 確保訂單號碼存在，否則跳過
            order_number = data["訂單號碼"].to_s.strip
            next if order_number.blank?

            email = data["電郵"].to_s.strip
            product_name = data["商品名稱"].to_s.strip
            
            # 查找相關客戶
            customer = ShoplineCustomer.find_by(email: email) if email.present?

            # 處理日期 - 首先嘗試從訂單日期欄位解析
            order_date = parse_datetime(data["訂單日期"])
            
            # 如果無法解析，嘗試從訂單號碼推斷日期
            if order_date.nil? && order_number.present?
              # 如果訂單號碼格式為 #YYYYMMDD...
              if order_number.start_with?('#') && order_number.length >= 13
                begin
                  year = order_number[1..4].to_i
                  month = order_number[5..6].to_i
                  day = order_number[7..8].to_i
                  
                  if year.between?(2000, 2100) && month.between?(1, 12) && day.between?(1, 31)
                    order_date = DateTime.new(year, month, day)
                    
                    # 如果訂單號碼中包含時間 (格式如 #YYYYMMDDHHMMSS)
                    if order_number.length >= 19
                      hour = order_number[9..10].to_i
                      minute = order_number[11..12].to_i
                      second = order_number[13..14].to_i
                      
                      if hour.between?(0, 23) && minute.between?(0, 59) && second.between?(0, 59)
                        order_date = DateTime.new(year, month, day, hour, minute, second)
                      end
                    end
                  end
                rescue => e
                  # 忽略日期解析錯誤，繼續使用nil
                  Rails.logger.warn("從訂單號碼解析日期失敗: #{order_number}, 錯誤: #{e.message}")
                end
              end
            end

            # 建立或更新訂單
            order = ShoplineOrder.find_or_initialize_by(
              order_number: order_number,
              product_name: product_name
            )

            order.assign_attributes(
              email: email,
              instagram_account: data["ig帳號"],
              payment_status: data["付款狀態"],
              order_status: data["訂單狀態"],
              total_amount: parse_currency(data["付款總金額"]),
              quantity: data["數量"].to_i,
              customer_name: data["顧客"],
              payment_method: data["付款方式"],
              order_date: order_date,
              utm_source: data["UTM 來源"],
              utm_medium: data["UTM 媒介"],
              utm_source_medium: data["UTM 來源/媒介"],
              utm_campaign: data["UTM 活動名稱"],
              utm_term: data["UTM 活動字詞"],
              utm_content: data["UTM 活動內容"],
              utm_clicked_at: parse_datetime(data["UTM 點擊時間"]),
              membership_level: data["會員等級"]
            )
            
            # 只在客戶存在時設置關聯
            order.shopline_customer_id = customer.id if customer.present?

            order.save!
            success_count += 1
          end  # 事務結束
        rescue => e
          # 記錄錯誤但繼續處理下一筆
          error_list << "❌ 第 #{i} 行錯誤: #{e.message}"
        end
      end

      # 將錯誤列表存儲在 Rails.cache 中
      if error_list.any?
        # 限制錯誤訊息的大小，避免溢出
        if error_list.size > 50
          truncated_errors = error_list.take(50)
          truncated_errors << "...還有 #{error_list.size - 50} 筆錯誤 (查看詳細錯誤請檢查日誌)"
          error_list = truncated_errors
        end
        
        Rails.cache.write("order_import_errors_#{current_admin.id}", error_list, expires_in: 1.hour)
        flash[:warning] = "⚠️ 部分資料匯入失敗，共有 #{error_list.size} 筆錯誤"
        redirect_to import_errors_admin_shopline_order_imports_path
      else
        flash[:success] = "🎉 匯入完成，共成功處理 #{success_count} 筆資料"
        redirect_to admin_shopline_orders_path
      end
    rescue => e
      flash[:alert] = "❌ 上傳失敗: #{e.message}"
      redirect_to new_admin_shopline_order_import_path
    end
  end

  def import_errors
    @errors = Rails.cache.read("order_import_errors_#{current_admin.id}") || []
  end

  private

  def parse_currency(value)
    return 0 if value.blank?
    value.to_s.gsub(/[^\d.]/, "").to_f
  end

  def parse_datetime(value)
    return nil if value.blank?
    
    # 嘗試多種格式解析
    begin
      # 標準 DateTime 解析
      return DateTime.parse(value.to_s) 
    rescue => e
      # 嘗試不同的格式
      begin
        # 處理 Excel 數值格式的日期
        if value.is_a?(Numeric) && value.to_f > 0
          # Excel 日期從1900-01-01開始計算
          base_date = DateTime.new(1900, 1, 1)
          days = value.to_f
          
          # Excel 1900年錯誤修正：Excel錯誤地認為1900是閏年
          days -= 1 if days > 59
          
          return base_date + days - 1
        end
        
        # 處理 YYYY/MM/DD 或 YYYY-MM-DD 格式
        if value.to_s.match?(/^\d{4}[\/\-]\d{1,2}[\/\-]\d{1,2}/)
          parts = value.to_s.split(/[\/\-]/)
          year = parts[0].to_i
          month = parts[1].to_i
          day = parts[2].to_i
          
          if year.between?(2000, 2100) && month.between?(1, 12) && day.between?(1, 31)
            return DateTime.new(year, month, day)
          end
        end
        
        # 處理 MM/DD/YYYY 格式
        if value.to_s.match?(/^\d{1,2}[\/\-]\d{1,2}[\/\-]\d{4}/)
          parts = value.to_s.split(/[\/\-]/)
          month = parts[0].to_i
          day = parts[1].to_i
          year = parts[2].to_i
          
          if year.between?(2000, 2100) && month.between?(1, 12) && day.between?(1, 31)
            return DateTime.new(year, month, day)
          end
        end
        
        # 處理 DD-MMM-YYYY 格式 (例如: 04-Jan-2024)
        if value.to_s.match?(/^\d{1,2}-[A-Za-z]{3}-\d{4}$/)
          return DateTime.parse(value.to_s)
        end
      rescue => nested_error
        Rails.logger.warn("日期解析失敗 (二次嘗試): #{value.inspect}, 錯誤: #{nested_error.message}")
      end
    end
    
    nil  # 如果所有嘗試都失敗，返回 nil
  end

  def parse_date(value)
    datetime = parse_datetime(value)
    datetime&.to_date
  end
end