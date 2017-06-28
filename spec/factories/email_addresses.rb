FactoryGirl.define do
  factory :email_address do
    sequence :address { |n| "factory-email-#{n}@gmail.com" }
    sequence :confirmation_token { |n| "tok3n-#{n}" }
    user

    trait :primary do
      address_type EmailAddress::PRIMARY_TYPE
    end

    trait :alert do
      address_type EmailAddress::ALERT_TYPE
    end
  end
end
