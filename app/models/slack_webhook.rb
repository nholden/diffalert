class SlackWebhook < ApplicationRecord

  belongs_to :user
  has_many :triggers

  validates :url,
    presence: true,
    format: { with: Patterns::SLACK_WEBHOOK_URL_REGEX }

end
