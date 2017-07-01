class CreateSlackWebhooksForTriggers < ActiveRecord::Migration[5.1]
  def change
    Trigger.all.each do |trigger|
      if slack_webhook = SlackWebhook.find_by(user_id: trigger.user_id, url: trigger.slack_webhook_url)
        trigger.update! slack_webhook_id: slack_webhook.id
      else
        if User.find_by_id(trigger.user_id)
          if trigger.slack_webhook_url.present?
            trigger.create_slack_webhook!(
              user_id: trigger.user_id,
              url: trigger.slack_webhook_url,
            )
            trigger.save!
          end
        else
          trigger.delete
        end
      end
    end
  end
end
