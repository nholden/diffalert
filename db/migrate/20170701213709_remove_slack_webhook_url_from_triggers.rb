class RemoveSlackWebhookUrlFromTriggers < ActiveRecord::Migration[5.1]
  def change
    remove_column :triggers, :slack_webhook_url
  end
end
