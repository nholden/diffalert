class UserRegistration

  include ActiveModel::Model
  include ActiveRecord::SecureToken

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
    create_user!
    send_confirmation_email
  end

  private

  def email_must_be_available
    if User.where('lower(email) = ?', email.downcase).any?
      errors[:email] << 'cannot be taken'
    end
  end

  def create_user!
    @user = User.create! do |user|
      user.email = email
      user.password = password
      user.password_confirmation = password_confirmation
      user.github_events_secret = self.class.generate_unique_secure_token
      user.email_confirmation_token = self.class.generate_unique_secure_token
    end
  end

  def send_confirmation_email
    UserConfirmationEmailWorker.perform_async(user.id)
  end

end
