require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "authentication" do

  describe "log in" do
    Given { FactoryGirl.create(:user, email: 'nick@nickholden.io', password: 'letmein', password_confirmation: 'letmein') }

    When { visit new_session_path }
    When { fill_in 'Email', with: 'nick@nickholden.io' }
    When { fill_in 'Password', with: password }
    When { click_button 'Log in' }

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
