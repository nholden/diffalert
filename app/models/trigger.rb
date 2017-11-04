class Trigger < ApplicationRecord

  belongs_to :user
  belongs_to :email_address, optional: true
  belongs_to :slack_webhook, optional: true
  has_many :alerts
  has_one :recent_alert, -> { order(created_at: :desc) }, class_name: 'Alert'

  scope :for_event, -> (event) { where(repository_name: event.repository_name).
                                   where('modified_path IN (?) OR modified_path IS NULL', event.modified_paths).
                                   where('branch = ? OR branch IS NULL', event.branch) }
  scope :ordered_for_index, -> { order('lower(repository_name), lower(branch), lower(modified_path)') }

  validates :message, :repository_name, presence: true

  delegate :address, to: :email_address, prefix: true, allow_nil: true
  delegate :url, to: :slack_webhook, prefix: true, allow_nil: true

end
