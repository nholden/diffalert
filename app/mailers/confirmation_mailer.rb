class ConfirmationMailer < ApplicationMailer

  layout 'confirmation_mailer'

  def primary_email_address(email_address)
    @email_address = email_address.decorate
    mail(to: email_address.address, subject: "Confirm your email address")
  end

end
