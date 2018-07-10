class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      activate_check user
    else
      flash.now[:danger] = I18n.t "log_in.error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def remember_check user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end

  def activate_check user
    if user.activated?
      log_in user
      remember_check user
      redirect_to user
    else
      flash[:warning] = I18n.t "activate_mail.message"
      redirect_to root_url
    end
  end
end
