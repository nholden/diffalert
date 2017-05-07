FactoryGirl.define do
  factory :alert do
    trigger_id 1
    email "test@gmail.com"
    slack_webhook_url "https://hooks.slack.com/FOOBAR"
    message "Check out this alert!"
  end
end
