class ApplicationMailer < ActionMailer::Base

  default from: ENV.fetch('DEFAULT_SEND_FROM')

  def default_url_options
    { host: ENV.fetch('APP_HOST') }
  end

end
