class UserRegistration

  include ActiveModel::Model

  attr_accessor(
    :email,
    :password,
    :password_confirmation
  )

  attr_reader :user

  validates :email,
    presence: true,
    format: { with: Patterns::EMAIL_REGEX }

  validates :password,
    presence: true,
    length: { minimum: 6 },
    confirmation: true

  validate :email_must_be_available

  def save!
    @user = User.create! do |user|
      user.email = email
      user.password = password
      user.password_confirmation = password_confirmation
      user.github_events_secret = SecureRandom.hex(20)
    end
  end

  private

  def email_must_be_available
    if User.where('lower(email) = ?', email.downcase).any?
      errors[:email] << 'cannot be taken'
    end
  end

end
