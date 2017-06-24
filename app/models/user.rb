class User < ApplicationRecord

  has_many :triggers
  has_many :alerts, through: :triggers

  has_secure_password

  validates :email,
    presence: true,
    format: { with: Patterns::EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :password,
    length: { minimum: 6 },
    allow_nil: true

  def email_confirmed?
    email_confirmed_at.present?
  end

  def confirm_email!
    update! email_confirmed_at: Time.current
  end

end
