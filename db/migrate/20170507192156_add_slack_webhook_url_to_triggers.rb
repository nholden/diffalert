class AddSlackWebhookUrlToTriggers < ActiveRecord::Migration[5.0]
  def change
    add_column :triggers, :slack_webhook_url, :string
  end
end
