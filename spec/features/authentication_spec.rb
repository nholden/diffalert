require 'rails_helper'

RSpec.describe "authentication" do

  describe "user sign-up" do
    When { visit new_user_path }
    When { fill_in 'Email', with: 'nick@realhq.com' }
    When { fill_in 'Password', with: password }
    When { fill_in 'Confirm password', with: password_confirmation }
    When { click_button 'Sign up' }

    context "with matching passwords" do
      Given(:password) { 'password' }
      Given(:password_confirmation) { 'password' }

      Then { expect(page).to have_content 'You’re signed up!' }
      And { expect(page).to have_content 'nick@realhq.com' }
      And { User.last.email == 'nick@realhq.com' }
    end

    context "without matching passwords" do
      Given(:password) { 'password' }
      Given(:password_confirmation) { 'passsword' }

      Then { expect(page).to have_content 'Passwords don’t match' }
      And { User.where(email: 'nick@realhq.com').empty? }
    end
  end

  describe "user login" do
    Given { FactoryGirl.create(:user, email: 'nick@nickholden.io', password: 'letmein', password_confirmation: 'letmein') }

    When { visit new_session_path }
    When { fill_in 'Email', with: 'nick@nickholden.io' }
    When { fill_in 'Password', with: password }
    When { click_button 'Login' }

    context "with vaild credentials" do
      Given(:password) { 'letmein' }

      Then { expect(page).to have_content 'Welcome back!' }
      And { expect(page).to have_content 'nick@nickholden.io' }
    end

    context "with invalid credentials" do
      Given(:password) { 'invalid' }

      Then { expect(page).to have_content 'Invalid email/password combination' }
    end
  end

end
