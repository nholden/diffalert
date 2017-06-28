class DropEmailColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :email_confirmation_token
    remove_column :users, :email_confirmed_at
  end
end
