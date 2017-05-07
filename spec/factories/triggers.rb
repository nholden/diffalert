FactoryGirl.define do
  factory :trigger do
    user
    modified_file "todo.md"
    email "test@gmail.com"
    slack_webhook_url "https://hooks.slack.com/services/FOO/BAR/FOOBAR"
    message "Hello world!"
    branch "master"
    repository_name "sandbox"
  end
end
