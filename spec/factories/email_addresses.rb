FactoryBot.define do
  sequence(:address) { |n| "factory-email-#{n}@gmail.com" }
  sequence(:confirmation_token) { |n| "tok3n-#{n}" }

  factory :email_address do
    address
    confirmation_token
    user

    trait :primary do
      address_type EmailAddress::PRIMARY_TYPE
    end

    trait :alert do
      address_type EmailAddress::ALERT_TYPE
    end
  end
end
