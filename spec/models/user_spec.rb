require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    Given(:user) { User.new(FactoryGirl.attributes_for(:user)) }

    context "email" do
      When { user.email = email }

      context "it is valid when email is valid" do
        Given(:email) { 'dustin@firsttraxcoffee.com' }
        Then { user.valid? }
      end

      context "it is invalid when email is invalid" do
        Given(:email) { 'dustin@firsttraxcoffee' }
        Then { !user.valid? }
      end

      context "it is invalid when email is blank" do
        Given(:email) { ' ' }
        Then { !user.valid? }
      end

      context "it is invalid when another user with that email exists" do
        Given { FactoryGirl.create(:user, email: 'dustin@firsttraxcoffee.com') }
        Given(:email) { 'Dustin@firsttraxcoffee.com' }

        Then { !user.valid? }
      end
    end

    context "password and password confirmation" do
      When { user.password = password }
      When { user.password_confirmation = password_confirmation }

      context "it is valid when password is valid" do
        Given(:password) { 'password' }
        Given(:password_confirmation) { 'password' }

        Then { user.valid? }
      end

      context "it is invalid when password doesn't match password_confirmation" do
        Given(:password) { 'password' }
        Given(:password_confirmation) { 'Password' }

        Then { !user.valid? }
      end

      context "it is invalid when password is less than six characters" do
        Given(:password) { 'passw' }
        Given(:password_confirmation) { 'passw' }

        Then { !user.valid? }
      end

      context "it is invalid when password is blank" do
        Given(:password) { '' }
        Given(:password_confirmation) { '' }

        Then { !user.valid? }
      end
    end

  end

end
