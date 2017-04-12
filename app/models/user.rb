class User < ApplicationRecord

  has_many :triggers
  has_many :alerts, through: :triggers

  has_secure_password

  validates :email,
    presence: true,
    format: { with: Patterns::VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password,
    presence: true,
    length: { minimum: 6 }

end
