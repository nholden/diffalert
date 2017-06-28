require 'rails_helper'

RSpec.describe "sign up" do

  Given { PrimaryEmailAddressConfirmationWorker.jobs.clear }

  When { visit new_user_registration_path }
  When { fill_in 'Email', with: 'nick@realhq.com' }
  When { fill_in 'Password', with: password }
  When { fill_in 'Confirm password', with: password_confirmation }
  When { click_button 'Sign up' }

  context "with matching passwords" do
    Given(:user) { User.last! }
    Given(:primary_email_address) { user.primary_email_address }
    Given(:password) { 'password' }
    Given(:password_confirmation) { 'password' }

    Then { expect(page).to have_content 'You’re signed up!' }
    And { user.username == 'nick@realhq.com' }
    And { user.github_events_secret.present? }
    And { primary_email_address.address == 'nick@realhq.com' }
    And { primary_email_address.confirmed_at.nil? }
    And { primary_email_address.confirmation_token.present? }
    And { PrimaryEmailAddressConfirmationWorker.jobs.one? }
  end

  context "without matching passwords" do
    Given(:password) { 'password' }
    Given(:password_confirmation) { 'passsword' }

    Then { expect(page).to have_content 'This field doesn\'t match Password.' }
    And { User.where(username: 'nick@realhq.com').empty? }
    And { PrimaryEmailAddressConfirmationWorker.jobs.none? }
  end

end
