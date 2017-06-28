class CreatePrimaryEmailAddressesForExistingUsers < ActiveRecord::Migration[5.1]

  include ActiveRecord::SecureToken

  def change
    User.all.each do |user|
      user.create_primary_email_address!(
        address: user.username,
        confirmed_at: user.email_confirmed_at,
        confirmation_token: user.email_confirmation_token || self.class.generate_unique_secure_token 
      )
    end
  end
end
