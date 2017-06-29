class User < ApplicationRecord

  has_many :triggers
  has_many :alerts, through: :triggers
  has_many :email_addresses
  has_one :primary_email_address, -> { where address_type: EmailAddress::PRIMARY_TYPE }, class_name: 'EmailAddress'

  has_secure_password
  has_secure_token :github_events_secret

  validates :username,
    presence: true,
    format: { with: Patterns::EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password,
    length: { minimum: 6 },
    allow_nil: true

end
