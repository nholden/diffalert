class AddEmailSlackWebhookUrlAndMessageToAlerts < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :email, :string
    add_column :alerts, :slack_webhook_url, :string
    add_column :alerts, :message, :text
  end
end
