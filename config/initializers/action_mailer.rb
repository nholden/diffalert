Rails.application.config.action_mailer.smtp_settings = {
  :authentication => :login,
  :address => "smtp.mailgun.org",
  :port => 587,
  :domain => ENV['MAILGUN_DOMAIN'],
  :user_name => ENV['MAILGUN_SMTP_LOGIN'],
  :password => ENV['MAILGUN_SMTP_PASSWORD']
}

