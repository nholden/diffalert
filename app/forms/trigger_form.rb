class TriggerForm

  include ActiveModel::Model
  include Draper::Decoratable

  attr_accessor(
    :trigger,
    :user,
    :email_address,
    :repository_name,
    :branch,
    :modified_file,
    :email_address_address,
    :slack_webhook_url,
    :message,
  )

  validates :modified_file, :message, :branch, :repository_name, presence: true
  validates :email_address_address, format: { with: Patterns::EMAIL_REGEX }, allow_blank: true
  validates :slack_webhook_url, format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }, allow_blank: true
  validate :must_have_email_address_address_or_slack_webhook_url

  delegate :id, to: :trigger, prefix: true

  def save!
    Trigger.transaction do
      save_email_address!
      save_trigger!
    end
  end

  def set_default_data
    self.repository_name = trigger.repository_name
    self.branch = trigger.branch
    self.modified_file = trigger.modified_file
    self.email_address_address = trigger.email_address_address
    self.slack_webhook_url = trigger.slack_webhook_url
    self.message = trigger.message
  end

  private

  def save_email_address!
    if email_address_address.present?
      self.email_address ||= user.email_addresses.find_or_initialize_by(address: email_address_address)
      self.email_address.address_type ||= EmailAddress::ALERT_TYPE
      self.email_address.address = email_address_address
      email_address.save! if email_address.new_record? || email_address.changed?
    else
      self.email_address = nil
    end
  end

  def save_trigger!
    self.trigger ||= Trigger.new
    self.trigger.user = user
    self.trigger.repository_name = repository_name
    self.trigger.branch = branch
    self.trigger.modified_file = modified_file
    self.trigger.slack_webhook_url = slack_webhook_url
    self.trigger.message = message
    self.trigger.email_address = email_address
    trigger.save! if trigger.new_record? || trigger.changed?
  end

  def must_have_email_address_address_or_slack_webhook_url
    if email_address_address.blank? && slack_webhook_url.blank?
      errors[:email_address_address] << 'can\'t be blank without a Slack webhook URL'
      errors[:slack_webhook_url] << 'can\'t be blank without an email'
    end
  end

end
