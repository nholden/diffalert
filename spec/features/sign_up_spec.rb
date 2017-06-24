require 'rails_helper'

RSpec.describe "sign up" do

  When { visit new_user_path }
  When { fill_in 'Email', with: 'nick@realhq.com' }
  When { fill_in 'Password', with: password }
  When { fill_in 'Confirm password', with: password_confirmation }
  When { click_button 'Sign up' }

  context "with matching passwords" do
    Given(:password) { 'password' }
    Given(:password_confirmation) { 'password' }

    Then { expect(page).to have_content 'You’re signed up!' }
    And { User.last.email == 'nick@realhq.com' }
    And { User.last.github_events_secret.present? }
  end

  context "without matching passwords" do
    Given(:password) { 'password' }
    Given(:password_confirmation) { 'passsword' }

    Then { expect(page).to have_content 'This field doesn\'t match Password.' }
    And { User.where(email: 'nick@realhq.com').empty? }
  end

end
