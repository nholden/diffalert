class Trigger < ApplicationRecord

  belongs_to :user
  belongs_to :email_address, optional: true
  belongs_to :slack_webhook, optional: true
  has_many :alerts
  has_one :recent_alert, -> { order(created_at: :desc) }, class_name: 'Alert'

  scope :for_event, -> (event) { where(repository_name: event.repository_name).
                                   where('modified_file IN (?) OR modified_file IS NULL', event.modified_files).
                                   where('branch = ? OR branch IS NULL', event.branch) }
  scope :ordered_for_index, -> { order('lower(repository_name), lower(branch), lower(modified_file)') }

  validates :message, :repository_name, presence: true

  delegate :address, to: :email_address, prefix: true, allow_nil: true
  delegate :url, to: :slack_webhook, prefix: true, allow_nil: true

end
