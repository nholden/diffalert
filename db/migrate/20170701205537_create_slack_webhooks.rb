class CreateSlackWebhooks < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_webhooks do |t|
      t.string :url
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    add_index :slack_webhooks, :user_id
  end
end
