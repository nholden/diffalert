FactoryGirl.define do
  factory :trigger do
    user
    modified_file "todo.md"
    slack_webhook_url "https://hooks.slack.com/services/FOO/BAR/FOOBAR"
    message "Hello world!"
    branch "master"
    repository_name "sandbox"

    after(:build) do |trigger|
      if trigger.email_address.nil?
        trigger.email_address = build(:email_address, :primary, user: trigger.user)
      end
    end
  end
end
