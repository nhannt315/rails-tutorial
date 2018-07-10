class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "log_in.require"
    redirect_to login_url
  end
end
