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
      @shopline_customer = ShoplineCustomer.find(params[:id])
    
      @shopline_customer.build_health_questionnaire unless @shopline_customer.health_questionnaire
      @shopline_customer.build_health_assessment unless @shopline_customer.health_assessment
    
      # 推薦產品需要初始至少 1 筆空物件（避免畫面沒欄位）
      if @shopline_customer.health_assessment
        @shopline_customer.health_assessment.health_assessment_products.build if @shopline_customer.health_assessment.health_assessment_products.empty?
      end
    end

    def update
      # ... (Steps 1 & 2 for product_ids handling) ...
        
      ActiveRecord::Base.transaction do
        # ... (Step 1: Product ID logic) ...
        
        # --- 2. 更新基本欄位 + 健康問卷 + 健康分析 (Mass Assignment) ---
        @shopline_customer.update!(shopline_customer_params)
      end
        
      redirect_to admin_shopline_customer_path(@shopline_customer),
                  notice: "客戶資料已成功更新。"
        
    rescue ActiveRecord::RecordInvalid => e
      # ⚠️ MODIFIED DEBUGGING CODE HERE
      puts "\n\n❌ VALIDATION ERROR DEBUG START ❌"
      puts "Error Message: #{e.message}"
      # Print the full list of errors on the customer and its nested models
      puts "Customer Errors: #{@shopline_customer.errors.full_messages}"
      
      # Check nested model errors
      if @shopline_customer.health_questionnaire&.errors.any?
        puts "Questionnaire Errors: #{@shopline_customer.health_questionnaire.errors.full_messages}"
      end
      if @shopline_customer.health_assessment&.errors.any?
        puts "Assessment Errors: #{@shopline_customer.health_assessment.errors.full_messages}"
      end
      puts "❌ VALIDATION ERROR DEBUG END ❌\n\n"
      # ⚠️ END OF MODIFIED DEBUGGING CODE
      
      flash.now[:alert] = "更新失敗: #{e.message}"
      render :edit
    end
      
      
    private
  
    def set_shopline_customer
      @shopline_customer = ShoplineCustomer.find(params[:id])
    end
  
    def shopline_customer_params
      params.require(:shopline_customer).permit(
        :personal_note,
    
        health_questionnaire_attributes: [
          :id,
          :height_cm, :weight_kg, :body_fat_percentage,
          :work_type, :marital_status,
          :sleep_time, :wake_time,
          :water_intake_ml,
          :previous_weight_loss_methods,
          :purchase_reason,           
          :currently_weight_loss,    
          :diet_type_other,           
          diet_type: []
        ],
    
        health_assessment_attributes: [
          :id,
          :interaction_level,
          :main_health_goal,
          :summary_notes
        ]
      )
    end
    
         
    
  end