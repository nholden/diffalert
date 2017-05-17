class AlertMailer < ApplicationMailer

  default from: ENV.fetch('DEFAULT_SEND_FROM')

  def modified_file_email(alert)
    @alert = alert
    mail(to: @alert.email, subject: "DiffAlert: #{@alert.trigger.modified_file} has been modified")
  end

end
