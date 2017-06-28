FactoryGirl.define do
  factory :email_address do
    address "foo@bar.com"
    address_type "MyString"
    sequence :confirmation_token { |n| "tok3n-#{n}" }
    user

    trait :primary do
      address_type EmailAddress::PRIMARY_TYPE
    end
  end
end
