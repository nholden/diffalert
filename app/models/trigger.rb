class Trigger < ApplicationRecord

  belongs_to :user
  has_many :alerts

  scope :for_event, -> (event) { where(modified_file: event.modified_files,
                                       branch: event.branch,
                                       repository_name: event.repository_name) }

  validates :modified_file, :message, :branch, :repository_name, presence: true
  validates :email, format: { with: Patterns::EMAIL_REGEX }, allow_blank: true
  validates :slack_webhook_url, format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }, allow_blank: true
  validate :must_have_email_or_slack_webhook_url

  private

  def must_have_email_or_slack_webhook_url
    if email.blank? && slack_webhook_url.blank?
      errors[:base] << 'A trigger must have an email and/or a Slack webhook URL'
    end
  end

end
