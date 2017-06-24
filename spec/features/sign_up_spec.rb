require 'rails_helper'

RSpec.describe "sign up" do

  Given { UserConfirmationEmailWorker.jobs.clear }

  When { visit new_user_registration_path }
  When { fill_in 'Email', with: 'nick@realhq.com' }
  When { fill_in 'Password', with: password }
  When { fill_in 'Confirm password', with: password_confirmation }
  When { click_button 'Sign up' }

  context "with matching passwords" do
    Given(:user) { User.last! }
    Given(:password) { 'password' }
    Given(:password_confirmation) { 'password' }

    Then { expect(page).to have_content 'You’re signed up!' }
    And { user.email == 'nick@realhq.com' }
    And { user.github_events_secret.present? }
    And { user.email_confirmed_at.nil? }
    And { UserConfirmationEmailWorker.jobs.one? }
  end

  context "without matching passwords" do
    Given(:password) { 'password' }
    Given(:password_confirmation) { 'passsword' }

    Then { expect(page).to have_content 'This field doesn\'t match Password.' }
    And { User.where(email: 'nick@realhq.com').empty? }
    And { UserConfirmationEmailWorker.jobs.none? }
  end

end
