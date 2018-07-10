class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: I18n.t("activate_mail.title ")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: I18n.t("reset_mail.title")
  end
end
