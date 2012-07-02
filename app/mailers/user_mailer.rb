class UserMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "admin@bridled.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user_name, user_email)
    @user_name = user_name
    @user_email = user_email
    mail to: user_email, subject: "Dum dum de dum... get started with Bridled!"
  end
end
