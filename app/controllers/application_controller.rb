class ApplicationController < ActionController::Base
    before_action :require_login
  
    helper_method :current_admin, :logged_in?

    include Pagy::Backend

    def authenticate_admin!
      unless current_user && current_user.admin?
        flash[:alert] = '請先登入管理員帳號'
        redirect_to new_user_session_path # 或其他登入頁面
      end
    end
  
    private
  
    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
    end
  
    def logged_in?
      !!current_admin
    end
  
    def require_login
      unless logged_in?
        flash[:alert] = "請先登入"
        redirect_to login_path
      end
    end
  end
  