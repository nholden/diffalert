class AddUniqueIndiciesToTokenColumns < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
    add_index :users, :github_events_secret, unique: true
    add_index :users, :email_confirmation_token, unique: true
  end
end
