class SessionsController < ApplicationController
  layout "auth" # 指定使用 auth.html.erb
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    Rails.logger.info "登入嘗試: #{params[:email]}"
    admin = Admin.find_by(email: params[:email])
  
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      Rails.logger.info "登入成功: #{admin.id}, 重定向到: #{root_path}"
      redirect_to root_path, notice: "登入成功"
    else
      Rails.logger.info "登入失敗: 電子郵件或密碼錯誤"
      flash[:alert] = "電子郵件或密碼錯誤"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_path, notice: "已登出"
  end
end
