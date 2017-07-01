class Trigger < ApplicationRecord

  belongs_to :user
  belongs_to :email_address, optional: true
  has_many :alerts
  has_one :recent_alert, -> { order(created_at: :desc) }, class_name: 'Alert'

  scope :for_event, -> (event) { where(modified_file: event.modified_files,
                                       branch: event.branch,
                                       repository_name: event.repository_name) }

  validates :modified_file, :message, :branch, :repository_name, presence: true
  validates :slack_webhook_url, format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }, allow_blank: true

  delegate :address, to: :email_address, prefix: true, allow_nil: true

end
