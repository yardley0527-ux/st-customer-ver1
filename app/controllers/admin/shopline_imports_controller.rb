# app/controllers/admin/shopline_imports_controller.rb
class Admin::ShoplineImportsController < ApplicationController  
  def new
    # 顯示上傳表單
  end
  
  def create
    if params[:file].blank?
      flash[:alert] = "請選擇要上傳的檔案"
      redirect_to new_admin_shopline_import_path
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

      ActiveRecord::Base.transaction do
        (2..sheet.last_row).each do |i|
          row = sheet.row(i)
          data = Hash[headers.zip(row)]

          # 跳過整行都是空值的 row
          next if row.compact.blank?

          begin
            # 確保 `顧客 ID` 存在，否則跳過
            shopline_id = data["顧客 ID"].to_s.strip
            next if shopline_id.blank?

            # 轉換資料格式
            customer = ShoplineCustomer.find_or_initialize_by(shopline_id: shopline_id)

            customer.assign_attributes(
              full_name: data["全名"].presence || "未知",
              email: data["電郵"],
              joined_at: parse_datetime(data["加入日期"]),
              join_source: data["加入來源"],
              language: data["語言"],
              order_count: data["訂單數"].to_i,
              total_amount: parse_currency(data["累積金額"]),
              issued_shopping_credits: parse_currency(data["已發放購物金"]),
              deducted_shopping_credits: parse_currency(data["已扣除購物金"]),
              used_shopping_credits: parse_currency(data["已使用購物金"]),
              current_shopping_credits: parse_currency(data["現有購物金"]),
              issued_points: data["已發放點數"].to_i,
              deducted_points: data["已扣除點數"].to_i,
              used_points: data["已使用點數"].to_i,
              current_points: data["現有點數"].to_i,
              is_member: parse_boolean(data["會員"]),
              member_registered_at: parse_datetime(data["會員註冊日期"]),
              member_registration_source: data["會員註冊來源"],
              facebook_id: data["Facebook 註冊 ID"],
              line_id: data["LINE 註冊 ID"],
              blacklisted: parse_boolean(data["黑名單"]),
              has_password: parse_boolean(data["已設置密碼"]),
              accept_email_marketing: parse_boolean(data["接受電郵優惠宣傳"]),
              accept_sms_marketing: parse_boolean(data["接受簡訊優惠宣傳"]),
              accept_fb_marketing: parse_boolean(data["接受 FB 優惠宣傳"]),
              accept_line_marketing: parse_boolean(data["接受 LINE 優惠宣傳"]),
              accept_whatsapp_marketing: parse_boolean(data["接受 WhatsApp 優惠宣傳"]),
              last_login_at: parse_datetime(data["最後登入時間"]),
              phone: data["聯絡電話"],
              country_code: data["國際電話區碼"],
              mobile_phone: data["會員綁定手機號碼"],
              recipient_name: data["收件人姓名"],
              recipient_phone: data["收件人電話"],
              address_1: data["地址 1"],
              address_2: data["地址 2"],
              city: data["城市"],
              state: data["地區/州/省份"],
              postal_code: data["郵政編號（如適用)"],
              country: data["國家／地區"],
              membership_level: data["會員級別"],
              membership_expiry_date: parse_date(data["會員有效期"]),
              gender: data["性別"],
              birthdate: parse_date(data["生日"]),
              instagram_account: data["ig帳號"],
              tags: data["標籤"],
              notes: data["備註"],
              utm_source: data["UTM 來源"],
              utm_medium: data["UTM 媒介"],
              utm_source_medium: data["UTM 來源/媒介"],
              utm_campaign: data["UTM 活動名稱"],
              utm_term: data["UTM 活動字詞"],
              utm_content: data["UTM 活動內容"],
              utm_clicked_at: parse_datetime(data["UTM 點擊時間"]),
              referrer_name: data["推薦人姓名"],
              referrer_email: data["推薦人電郵"],
              referrer_phone: data["推薦人手機"]
            )

            customer.save!
            success_count += 1
          rescue => e
            error_list << "❌ 第 #{i} 行錯誤: #{e.message}"
          end
        end
      end

      flash[:success] = "🎉 匯入完成，共成功處理 #{success_count} 筆資料"
      flash[:alert] = "⚠️ 部分資料匯入失敗，錯誤列表如下:\n#{error_list.join("\n")}" if error_list.any?
    rescue => e
      flash[:alert] = "❌ 上傳失敗: #{e.message}"
    end

    redirect_to root_path
  end

  def import_errors
    @errors = Rails.cache.read("import_errors_#{current_admin.id}") || []
  end

  private

  def parse_boolean(value)
    value.to_s.strip.downcase == "y"
  end

  def parse_currency(value)
    value.to_s.gsub(/[^\d.]/, "").to_f
  end

  def parse_datetime(value)
    DateTime.parse(value) rescue nil
  end

  def parse_date(value)
    Date.parse(value) rescue nil
  end
end