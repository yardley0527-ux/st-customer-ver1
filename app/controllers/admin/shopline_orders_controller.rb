# app/controllers/admin/shopline_orders_controller.rb
class Admin::ShoplineOrdersController < ApplicationController
  before_action :set_shopline_order, only: [:show, :edit, :update]

  def index
    # 建立基本查詢
    @orders_query = ShoplineOrder.all
    
    # 應用過濾條件
    if params[:month].present?
      year = params[:month][0..3].to_i
      month = params[:month][4..5].to_i
      
      if year > 0 && month.between?(1, 12)
        start_date = Date.new(year, month, 1)
        end_date = start_date.end_of_month
        @orders_query = @orders_query.where(order_date: start_date..end_date)
      end
    end
    
    # 應用其他篩選
    @orders_query = @orders_query.where(order_status: params[:order_status]) if params[:order_status].present?
    @orders_query = @orders_query.where(payment_status: params[:payment_status]) if params[:payment_status].present?
    
    # 搜索條件
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @orders_query = @orders_query.where(
        "order_number LIKE ? OR customer_name LIKE ? OR email LIKE ? OR product_name LIKE ?", 
        search_term, search_term, search_term, search_term
      )
    end
    
    # 計算統計資料（在分頁前進行）
    @orders_count = @orders_query.count
    @customer_count = @orders_query.select(:email).distinct.count
    @products_count = @orders_query.sum(:quantity)
    
    # 只計算已付款且已完成訂單的總金額 - 這是關鍵修改
    @total_amount = @orders_query.where(payment_status: "已付款", order_status: "已完成").sum(:total_amount)
    
    # 排序和分頁（在計算統計後進行）
    @orders_query = @orders_query.order(order_date: :desc)
    @pagy, @shopline_orders = pagy(@orders_query, items: params[:per_page] || 25)
    
    # 獲取可用月份（用於過濾器）
    @available_months = get_available_months
  end
     
  def show
  end

  def edit
  end

  def update
    if @shopline_order.update(shopline_order_params)
      redirect_to admin_shopline_order_path(@shopline_order), notice: '訂單資料已成功更新。'
    else
      render :edit
    end
  end

  private

  def get_available_months
    # 獲取所有具有訂單日期的不同月份
    begin
      months = ShoplineOrder.where.not(order_date: nil)
                            .select("DISTINCT TO_CHAR(order_date, 'YYYYMM') as month")
                            .map(&:month)
                            .compact
                            .sort
                            .reverse
      
      # 如果有訂單數據，但沒有日期數據，或無訂單數據
      return [Time.current.strftime("%Y%m")] if months.blank?
      
      months
    rescue => e
      # 如果有任何錯誤，返回當前月份
      Rails.logger.error("獲取月份列表失敗: #{e.message}")
      [Time.current.strftime("%Y%m")]
    end
  end

  def set_shopline_order
    @shopline_order = ShoplineOrder.find(params[:id])
  end

  def shopline_order_params
    params.require(:shopline_order).permit(
      :order_number, :product_name, :email, :instagram_account,
      :payment_status, :order_status, :total_amount, :quantity,
      :customer_name, :payment_method, :order_date,
      :utm_source, :utm_medium, :utm_source_medium, :utm_campaign,
      :utm_term, :utm_content, :utm_clicked_at, :membership_level,
      :shopline_customer_id
    )
  end
end