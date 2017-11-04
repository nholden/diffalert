FactoryBot.define do
  factory :trigger do
    user
    modified_file "todo.md"
    message "Hello world!"
    branch "master"
    repository_name "sandbox"

    after(:build) do |trigger|
      if trigger.email_address.nil?
        trigger.email_address = build(:email_address, :primary, user: trigger.user)
      end
    end

    after(:build) do |trigger|
      if trigger.slack_webhook.nil?
        trigger.slack_webhook = build(:slack_webhook, user: trigger.user)
      end
    end
  end
end
