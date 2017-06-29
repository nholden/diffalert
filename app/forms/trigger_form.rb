class TriggerForm

  include ActiveModel::Model

  attr_accessor(
    :repository_name,
    :branch,
    :modified_file,
    :email,
    :slack_webhook_url,
    :message,
  )

  validates :modified_file, :message, :branch, :repository_name, presence: true
  validates :email, format: { with: Patterns::EMAIL_REGEX }, allow_blank: true
  validates :slack_webhook_url, format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }, allow_blank: true
  validate :must_have_email_or_slack_webhook_url

  private

  def must_have_email_or_slack_webhook_url
    if email.blank? && slack_webhook_url.blank?
      errors[:email] << 'can\'t be blank without a Slack webhook URL'
      errors[:slack_webhook_url] << 'can\'t be blank without an email'
    end
  end

end
