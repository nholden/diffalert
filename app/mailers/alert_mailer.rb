class AlertMailer < ApplicationMailer

  default from: "\"DiffAlert\" <alerts@diffalert.nickholden.io>"

  def modified_file_email(alert)
    @alert = alert
    mail(to: @alert.email, subject: "DiffAlert: #{@alert.trigger.modified_file} has been modified")
  end

end
