class AlertMailer < ApplicationMailer

  layout 'alert_mailer'

  def modified_file_email(alert)
    @alert = alert
    mail(to: @alert.email, subject: "DiffAlert: #{@alert.trigger.modified_file} has been modified")
  end

end
