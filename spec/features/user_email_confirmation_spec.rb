require 'rails_helper'

RSpec.describe "user email confirmation" do

  around { |example| travel_to(Time.iso8601('2017-06-01T12:00:00-07:00'), &example) }

  Given(:user) { FactoryGirl.create(:user, email: 'test@email.com', email_confirmed_at: email_confirmed_at) }

  When { visit new_user_email_confirmation_path(user_id: user.id, token: token_param) }
  When { user.reload }

  context "when token is valid" do
    Given(:token_param) { user.email_confirmation_token }

    context "when email has not yet been confirmed" do
      Given(:email_confirmed_at) { nil }

      Then { expect(page).to have_text 'Thank you! You have confirmed test@email.com.' }
      And { expect(page).to have_current_path root_path }
      And { user.email_confirmed? }
      And { user.email_confirmed_at == Time.current }
    end

    context "when email has already been confirmed" do
      Given(:email_confirmed_at) { 1.year.ago }

      Then { expect(page).to have_text 'You have already confirmed test@email.com' }
      And { expect(page).to have_current_path root_path }
      And { user.email_confirmed? }
      And { user.email_confirmed_at == 1.year.ago }
    end
  end

  context "when token is invalid" do
    Given(:token_param) { 'not token' }
    Given(:email_confirmed_at) { nil }

    Then { expect(page).to have_text 'Invalid URL' }
    And { expect(page).to have_current_path root_path }
    And { !user.email_confirmed? }
    And { user.email_confirmed_at.nil? }
  end

end
