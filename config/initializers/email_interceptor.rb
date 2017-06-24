class EmailInterceptor

  def self.delivering_email(message)
    non_production_warning = [
      "***********",
      "This message was sent from #{ENV.fetch('RELEASE_STAGE')}.",
      "If it were sent from production, it would have been delivered to #{message.to.join(',')}",
      "***********<br><br>",
    ].join('<br>').html_safe

    message.subject = "[#{ENV.fetch('RELEASE_STAGE')}] #{message.subject}"
    message.to = [ENV.fetch('NON_PRODUCTION_SEND_TO')]
    message.cc = []
    message.bcc = []
    message.body = [non_production_warning, message.body].join
  end

end

unless ENV.fetch('RELEASE_STAGE') == 'production' || ActionMailer::Base.delivery_method == :test
  ActionMailer::Base.register_interceptor(EmailInterceptor) unless ENV.fetch('RELEASE_STAGE') == 'production'
end
