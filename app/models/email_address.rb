class EmailAddress < ApplicationRecord

  ADDRESS_TYPES = [
    PRIMARY_TYPE = 'primary',
  ]

  belongs_to :user

  validates :address,
    presence: true,
    format: { with: Patterns::EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :address_type, presence: true
  validates :confirmation_token, presence: true

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update! confirmed_at: Time.current
  end

end
