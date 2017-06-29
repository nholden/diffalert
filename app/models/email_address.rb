class EmailAddress < ApplicationRecord

  ADDRESS_TYPES = [
    PRIMARY_TYPE = 'primary',
    ALERT_TYPE = 'alert',
  ]

  belongs_to :user
  has_many :triggers

  has_secure_token :confirmation_token

  validates :address,
    presence: true,
    format: { with: Patterns::EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :address_type, presence: true

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update! confirmed_at: Time.current
  end

end
