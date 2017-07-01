class AddSlackWebhookIdToTriggers < ActiveRecord::Migration[5.1]
  def change
    add_column :triggers, :slack_webhook_id, :integer
    add_index :triggers, :slack_webhook_id
  end
end
