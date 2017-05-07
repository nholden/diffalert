FactoryGirl.define do
  factory :alert do
    trigger
    email "test@gmail.com"
    slack_webhook_url "https://hooks.slack.com/services/FOO/BAR/FOOBAR"
    message "Hello world!"
  end
end
