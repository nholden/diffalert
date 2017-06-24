class UserMailer < ApplicationMailer

  layout 'user_mailer'

  def confirmation_email(user)
    @user = user.decorate
    mail(to: user.email, subject: "Confirm your email address")
  end

end
