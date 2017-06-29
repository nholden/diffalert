class TriggerForm

  include ActiveModel::Model

  attr_accessor(
    :trigger,
    :user,
    :repository_name,
    :branch,
    :modified_file,
    :email,
    :slack_webhook_url,
    :message,
  )

  delegate :id, to: :trigger, prefix: true

  validates :modified_file, :message, :branch, :repository_name, presence: true
  validates :email, format: { with: Patterns::EMAIL_REGEX }, allow_blank: true
  validates :slack_webhook_url, format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }, allow_blank: true
  validate :must_have_email_or_slack_webhook_url

  def save!
    self.trigger ||= Trigger.new
    self.trigger.user = user
    self.trigger.repository_name = repository_name
    self.trigger.branch = branch
    self.trigger.modified_file = modified_file
    self.trigger.email = email
    self.trigger.slack_webhook_url = slack_webhook_url
    self.trigger.message = message
    trigger.save! if trigger.new_record? or trigger.changed?
  end

  def set_default_data
    self.repository_name = trigger.repository_name
    self.branch = trigger.branch
    self.modified_file = trigger.modified_file
    self.email = trigger.email
    self.slack_webhook_url = trigger.slack_webhook_url
    self.message = trigger.message
  end

  private

  def must_have_email_or_slack_webhook_url
    if email.blank? && slack_webhook_url.blank?
      errors[:email] << 'can\'t be blank without a Slack webhook URL'
      errors[:slack_webhook_url] << 'can\'t be blank without an email'
    end
  end

end
