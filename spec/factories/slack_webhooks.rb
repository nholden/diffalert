FactoryGirl.define do
  factory :slack_webhook do
    url "https://hooks.slack.com/services/FOO/BAR/FOOBAR"
    name "#diffalert"
    user
  end
end
