class AddNameToEmails < ActiveRecord::Migration[5.1]
  def change
    add_column :email_addresses, :name, :string
  end
end
