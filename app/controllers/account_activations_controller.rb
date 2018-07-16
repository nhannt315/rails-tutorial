class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user&.authenticated?(:activation, params[:id]) && !user.activated?
      user.activate
      log_in user
      flash[:success] = I18n.t "activate_mail.success"
      redirect_to user
    else
      flash[:danger] = I18n.t "activate_mail.fail"
      redirect_to root_url
    end
  end
end
