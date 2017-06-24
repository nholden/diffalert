require 'rails_helper'

RSpec.describe UserRegistration, type: :model do

  describe "validations" do
    Given(:user_registration) { UserRegistration.new(default_attrs) }

    Given(:default_attrs) { {
      email: 'nick@diffalert.org',
      password: 'passw0rd',
      password_confirmation: 'passw0rd',
    } }

    context "email" do
      When { user_registration.email = email }

      context "it is valid when email is valid" do
        Given(:email) { 'dustin@firsttraxcoffee.com' }
        Then { user_registration.valid? }
      end

      context "it is invalid when email is invalid" do
        Given(:email) { 'dustin@firsttraxcoffee' }
        Then { !user_registration.valid? }
      end

      context "it is invalid when email is blank" do
        Given(:email) { ' ' }
        Then { !user_registration.valid? }
      end

      context "it is invalid when a user with that email exists" do
        Given { FactoryGirl.create(:user, email: 'dustin@firsttraxcoffee.com') }
        Given(:email) { 'Dustin@firsttraxcoffee.com' }

        Then { !user_registration.valid? }
      end
    end

    context "password and password confirmation" do
      When { user_registration.password = password }
      When { user_registration.password_confirmation = password_confirmation }

      context "it is valid when password is valid" do
        Given(:password) { 'password' }
        Given(:password_confirmation) { 'password' }

        Then { user_registration.valid? }
      end

      context "it is invalid when password doesn't match password_confirmation" do
        Given(:password) { 'password' }
        Given(:password_confirmation) { 'Password' }

        Then { !user_registration.valid? }
      end

      context "it is invalid when password is less than six characters" do
        Given(:password) { 'passw' }
        Given(:password_confirmation) { 'passw' }

        Then { !user_registration.valid? }
      end

      context "it is invalid when password is blank" do
        Given(:password) { '' }
        Given(:password_confirmation) { '' }

        Then { !user_registration.valid? }
      end
    end

  end

end
