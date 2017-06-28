class AddEmailAddressIdToTriggers < ActiveRecord::Migration[5.1]
  def change
    add_column :triggers, :email_address_id, :integer
    add_index :triggers, :email_address_id
  end
end
