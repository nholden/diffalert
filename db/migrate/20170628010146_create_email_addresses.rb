class CreateEmailAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :email_addresses do |t|
      t.string :address
      t.string :address_type
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.integer :user_id

      t.timestamps
    end
    add_index :email_addresses, :address, unique: true
    add_index :email_addresses, :confirmation_token, unique: true
    add_index :email_addresses, :user_id
  end
end
