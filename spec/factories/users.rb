FactoryGirl.define do
  factory :user do
    github_events_secret "s3cr3t"
    password "password"
    password_confirmation "password"
    sequence :username { |n| "factory-email-#{n}@gmail.com" }

    after(:build) do |user|
      FactoryGirl.create(:email_address, :primary, user: user)
    end
  end
end
