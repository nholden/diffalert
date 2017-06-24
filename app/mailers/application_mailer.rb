class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('DEFAULT_SEND_FROM')
  layout 'mailer'
end

