class CreateTriggers < ActiveRecord::Migration[5.0]
  def change
    create_table :triggers do |t|
      t.integer :user_id
      t.string :modified_file

      t.timestamps
    end
    add_index :triggers, :user_id
  end
end
