class TriggerForm

  include ActiveModel::Model
  include Draper::Decoratable

  attr_accessor(
    :trigger,
    :user,
    :email_address,
    :slack_webhook,
    :repository_name,
    :branch,
    :all_branches,
    :modified_path,
    :all_modified_paths,
    :email_address_address,
    :email_address_name,
    :slack_webhook_url,
    :slack_webhook_name,
    :message,
    :github_url,
  )

  validates :message, :repository_name, presence: true
  validates :modified_path, presence: true, unless: :all_modified_paths_chosen?
  validates :branch, presence: true, unless: :all_branches_chosen?
  validates :email_address_address, format: { with: Patterns::EMAIL_REGEX }, allow_blank: true
  validates :slack_webhook_url, format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }, allow_blank: true
  validate :must_have_email_address_address_or_slack_webhook_url

  delegate :id, to: :trigger, prefix: true

  def save!
    Trigger.transaction do
      save_email_address!
      save_slack_webhook!
      save_trigger!
    end
  end

  def set_default_data
    if trigger
      self.repository_name = trigger.repository_name
      self.branch = trigger.branch
      self.all_branches = trigger.branch.nil?
      self.modified_path = trigger.modified_path
      self.all_modified_paths = trigger.modified_path.nil?
      self.email_address_address = trigger.email_address_address
      self.slack_webhook_url = trigger.slack_webhook_url
      self.message = trigger.message
    else
      self.all_branches = false
      self.all_modified_paths = false
    end
  end

  private

  def save_email_address!
    if email_address_address.present?
      self.email_address ||= user.email_addresses.find_or_initialize_by(address: email_address_address)
      self.email_address.address_type ||= EmailAddress::ALERT_TYPE

      if email_address_name.present?
        self.email_address.name = email_address_name
      end

      email_address.save! if email_address.new_record? || email_address.changed?
    else
      self.email_address = nil
    end
  end

  def save_slack_webhook!
    if slack_webhook_url.present?
      self.slack_webhook ||= user.slack_webhooks.find_or_initialize_by(url: slack_webhook_url)

      if slack_webhook_name.present?
        self.slack_webhook.name = slack_webhook_name
      end

      slack_webhook.save! if slack_webhook.new_record? || slack_webhook.changed?
    else
      self.slack_webhook = nil
    end
  end

  def save_trigger!
    self.trigger ||= Trigger.new
    self.trigger.user = user
    self.trigger.repository_name = repository_name
    self.trigger.branch = all_branches_chosen? ? nil : branch
    self.trigger.modified_path = all_modified_paths_chosen? ? nil : modified_path
    self.trigger.message = message
    self.trigger.email_address = email_address
    self.trigger.slack_webhook = slack_webhook
    trigger.save! if trigger.new_record? || trigger.changed?
  end

  def must_have_email_address_address_or_slack_webhook_url
    if email_address_address.blank? && slack_webhook_url.blank?
      errors[:email_address_address] << 'can\'t be blank without a Slack webhook URL'
      errors[:slack_webhook_url] << 'can\'t be blank without an email'
    end
  end

  def all_modified_paths_chosen?
    all_modified_paths == 'true'
  end

  def all_branches_chosen?
    all_branches == 'true'
  end

end
