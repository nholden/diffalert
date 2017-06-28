FactoryGirl.define do
  factory :user do
    password "password"
    password_confirmation "password"
    sequence :username { |n| "factory-email-#{n}@gmail.com" }
    sequence :github_events_secret { |n| "s3cr3t-#{n}" }

    after(:build) do |user, evaluator|
      if user.primary_email_address.nil?
        user.primary_email_address = build(:email_address, :primary, user: user)
      end
    end
  end
end
