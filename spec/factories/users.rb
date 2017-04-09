FactoryGirl.define do
  factory :user do
    github_events_secret "s3cr3t"
    password "password"
    password_confirmation "password"
    email "nick@gmail.com"
  end
end
