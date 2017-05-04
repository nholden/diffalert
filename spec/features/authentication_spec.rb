require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "authentication" do

  describe "sign-up" do
    When { visit new_user_path }
    When { fill_in 'Email', with: 'nick@realhq.com' }
    When { fill_in 'Password', with: password }
    When { fill_in 'Confirm password', with: password_confirmation }
    When { click_button 'Sign up' }

    context "with matching passwords" do
      Given(:password) { 'password' }
      Given(:password_confirmation) { 'password' }

      Then { expect(page).to have_content 'You’re signed up!' }
      And { expect(page).to have_content "Your GitHub webhook secret is #{User.last.github_events_secret}" }
      And { User.last.email == 'nick@realhq.com' }
      And { User.last.github_events_secret.present? }
    end

    context "without matching passwords" do
      Given(:password) { 'password' }
      Given(:password_confirmation) { 'passsword' }

      Then { expect(page).to have_content 'Passwords don’t match' }
      And { User.where(email: 'nick@realhq.com').empty? }
    end
  end

  describe "login" do
    Given { FactoryGirl.create(:user, email: 'nick@nickholden.io', password: 'letmein', password_confirmation: 'letmein') }

    When { visit new_session_path }
    When { fill_in 'Email', with: 'nick@nickholden.io' }
    When { fill_in 'Password', with: password }
    When { click_button 'Login' }

    context "with vaild credentials" do
      Given(:password) { 'letmein' }

      Then { expect(page).to have_content 'Welcome back, nick@nickholden.io!' }
    end

    context "with invalid credentials" do
      Given(:password) { 'invalid' }

      Then { expect(page).to have_content 'Invalid email/password combination' }
    end
  end

  describe "log out" do
    Given(:user) { FactoryGirl.create(:user) }

    When { log_in_as user }
    When { click_link 'Log out' }
    When { visit triggers_path }

    Then { expect(page).to have_content 'You must be logged in to view that page' }
  end

end
