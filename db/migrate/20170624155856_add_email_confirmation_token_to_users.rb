class AddEmailConfirmationTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_confirmation_token, :string
  end
end
