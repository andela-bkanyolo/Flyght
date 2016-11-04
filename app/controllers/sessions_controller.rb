class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: log_in_success(@user)
    else
      redirect_to login_path, alert: log_in_error
    end
  end

  def destroy
    name = current_user.full_name
    session[:user_id] = nil
    redirect_to root_path, notice: log_out_goodbye(name)
  end
end
