class AddMessageToTriggers < ActiveRecord::Migration[5.0]
  def change
    add_column :triggers, :message, :text
  end
end
