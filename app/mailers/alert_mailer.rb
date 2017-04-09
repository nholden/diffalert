class AlertMailer < ApplicationMailer

  default from: "\"DiffAlert\" <alerts@diffalert.nickholden.io>"

  def modified_file_email(alert)
    @trigger = alert.trigger
    mail(to: @trigger.email, subject: "DiffAlert: #{@trigger.modified_file} has been modified")
  end

end
