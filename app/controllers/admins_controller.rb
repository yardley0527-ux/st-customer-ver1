class AdminsController < ApplicationController
    before_action :require_admin
    before_action :require_login
  
    def dashboard
    end
  
    private
  
    def require_admin
      unless session[:admin_id]
        redirect_to login_path, alert: "請先登入"
      end
    end
  end
  