require 'rails_helper'

RSpec.describe UserRegistration, type: :model do

  describe "validations" do
    Given(:user_registration) { UserRegistration.new(default_attrs) }

    Given(:default_attrs) { {
      username: 'nick@diffalert.org',
      password: 'passw0rd',
      password_confirmation: 'passw0rd',
    } }

    context "username" do
      When { user_registration.username = username }

      context "it is valid when username is valid" do
        Given(:username ) { 'dustin@firsttraxcoffee.com' }
        Then { user_registration.valid? }
      end

      context "it is invalid when username is invalid" do
        Given(:username ) { 'dustin@firsttraxcoffee' }
        Then { !user_registration.valid? }
      end

      context "it is invalid when username is blank" do
        Given(:username ) { ' ' }
        Then { !user_registration.valid? }
      end

      context "it is invalid when a user with that username exists" do
        Given { FactoryGirl.create(:user, username: 'dustin@firsttraxcoffee.com') }
        Given(:username) { 'Dustin@firsttraxcoffee.com' }

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
