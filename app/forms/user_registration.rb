class UserRegistration

  include ActiveModel::Model
  include ActiveRecord::SecureToken

  attr_accessor(
    :username,
    :password,
    :password_confirmation
  )

  attr_reader :user

  validates :username,
    presence: true,
    format: { with: Patterns::EMAIL_REGEX }

  validates :password,
    presence: true,
    length: { minimum: 6 },
    confirmation: true

  validate :username_must_be_available

  def save!
    User.transaction do
      create_user!
      create_email_address!
      send_confirmation_email
    end
  end

  private

  def username_must_be_available
    if User.where('lower(username) = ?', username.downcase).any?
      errors[:username] << 'cannot be taken'
    end
  end

  def create_user!
    @user = User.create! do |user|
      user.username = username
      user.password = password
      user.password_confirmation = password_confirmation
      user.github_events_secret = self.class.generate_unique_secure_token
    end
  end

  def create_email_address!
    user.create_primary_email_address! do |email_address|
      email_address.address = user.username
      email_address.confirmation_token = self.class.generate_unique_secure_token
    end
  end

  def send_confirmation_email
    PrimaryEmailAddressConfirmationWorker.perform_async(user.primary_email_address.id)
  end

end
