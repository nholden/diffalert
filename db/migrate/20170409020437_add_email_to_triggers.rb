class AddEmailToTriggers < ActiveRecord::Migration[5.0]
  def change
    add_column :triggers, :email, :string
  end
end
