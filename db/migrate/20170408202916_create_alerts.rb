class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.integer :trigger_id

      t.timestamps
    end
    add_index :alerts, :trigger_id
  end
end
