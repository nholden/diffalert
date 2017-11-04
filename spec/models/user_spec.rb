require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    Given(:user) { User.new(FactoryBot.attributes_for(:user)) }

    context "username" do
      When { user.username = username }

      context "it is valid when username is valid" do
        Given(:username) { 'dustin@firsttraxcoffee.com' }
        Then { user.valid? }
      end

      context "it is invalid when username is invalid" do
        Given(:username) { 'dustin@firsttraxcoffee' }
        Then { !user.valid? }
      end

      context "it is invalid when username is blank" do
        Given(:username) { ' ' }
        Then { !user.valid? }
      end

      context "it is invalid when another user with that username exists" do
        Given { FactoryBot.create(:user, username: 'dustin@firsttraxcoffee.com') }
        Given(:username) { 'Dustin@firsttraxcoffee.com' }

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
