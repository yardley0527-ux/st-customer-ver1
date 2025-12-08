class Admin::ShoplineCustomersController < ApplicationController
    before_action :set_shopline_customer, only: [:show, :edit, :update]  
    def index
      membership_level = params[:membership_level]
      customers = ShoplineCustomer.where(membership_level: membership_level)
                                  .order(total_amount: :desc) # 按累積金額從高到低排序
    
      @pagy, @shopline_customers = pagy(customers)
      @membership_counts = ShoplineCustomer.group(:membership_level).count

    end
       
    def show
    end
  
    def edit
    end
  
    def update
      if @shopline_customer.update(shopline_customer_params)
        redirect_to admin_shopline_customers_path(membership_level: @shopline_customer.membership_level),
                    notice: '客戶資料已成功更新。'
      else
        render :edit
      end
    end    
  
    private
  
    def set_shopline_customer
      @shopline_customer = ShoplineCustomer.find(params[:id])
    end
  
    def shopline_customer_params
        params.require(:shopline_customer).permit(
          :shopline_id, :full_name, :email, :joined_at, :join_source, :language,
          :order_count, :total_amount, 
          :issued_shopping_credits, :deducted_shopping_credits, :used_shopping_credits, :current_shopping_credits,
          :issued_points, :deducted_points, :used_points, :current_points,
          :is_member, :member_registered_at, :member_registration_source,
          :facebook_id, :line_id, :blacklisted, :has_password,
          :accept_email_marketing, :accept_sms_marketing, :accept_fb_marketing, :accept_line_marketing, :accept_whatsapp_marketing,
          :last_login_at, :phone, :country_code, :mobile_phone, :recipient_name, :recipient_phone,
          :address_1, :address_2, :city, :state, :postal_code, :country,
          :membership_level, :membership_expiry_date, :gender, :birthdate, :instagram_account,
          :tags, :notes,
          :utm_source, :utm_medium, :utm_source_medium, :utm_campaign, :utm_term, :utm_content, :utm_clicked_at,
          :referrer_name, :referrer_email, :referrer_phone
        )
    end
  end