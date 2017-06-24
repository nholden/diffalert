FactoryGirl.define do
  factory :user do
    github_events_secret "s3cr3t"
    email_confirmation_token "t0k3n"
    password "password"
    password_confirmation "password"
    sequence :email { |n| "factory-email-#{n}@gmail.com" }
  end
end
