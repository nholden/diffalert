class DropEmailFromTriggers < ActiveRecord::Migration[5.1]
  def change
    remove_column :triggers, :email
  end
end
