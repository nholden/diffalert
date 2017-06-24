class AlertWorker

  include Sidekiq::Worker

  def perform(alert_id)
    alert = Alert.find(alert_id)

    if alert.email.present?
      AlertMailer.modified_file_email(alert).deliver
    end

    if alert.slack_webhook_url.present?
      Slack::Message.new(webhook_url: alert.slack_webhook_url, content: alert.message).send!
    end
  end

end
