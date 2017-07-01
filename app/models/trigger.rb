class Trigger < ApplicationRecord

  belongs_to :user
  belongs_to :email_address, optional: true
  belongs_to :slack_webhook, optional: true
  has_many :alerts
  has_one :recent_alert, -> { order(created_at: :desc) }, class_name: 'Alert'

  scope :for_event, -> (event) { where(modified_file: event.modified_files,
                                       branch: event.branch,
                                       repository_name: event.repository_name) }

  validates :modified_file, :message, :branch, :repository_name, presence: true

  delegate :address, to: :email_address, prefix: true, allow_nil: true
  delegate :url, to: :slack_webhook, prefix: true, allow_nil: true

end
