require 'rails_helper'

RSpec.describe "primary email address confirmation" do

  around { |example| travel_to(Time.iso8601('2017-06-01T12:00:00-07:00'), &example) }

  Given(:email_address) { FactoryGirl.create(:email_address, address: 'test@email.com', confirmed_at: confirmed_at) }
  Given { PrimaryEmailAddressConfirmationWorker.jobs.clear }

  describe "following an email confirmation link" do
    When { visit new_email_address_confirmation_path(email_address_id: email_address.id, token: token_param) }
    When { email_address.reload }

    context "when token is valid" do
      Given(:token_param) { email_address.confirmation_token }

      context "when email has not yet been confirmed" do
        Given(:confirmed_at) { nil }

        Then { expect(page).to have_text 'Thank you! You have confirmed test@email.com.' }
        And { expect(page).to have_current_path root_path }
        And { email_address.confirmed? }
        And { email_address.confirmed_at == Time.current }
      end

      context "when email has already been confirmed" do
        Given(:confirmed_at) { 1.year.ago }

        Then { expect(page).to have_text 'You have already confirmed test@email.com' }
        And { expect(page).to have_current_path root_path }
        And { email_address.confirmed? }
        And { email_address.confirmed_at == 1.year.ago }
      end
    end

    context "when token is invalid" do
      Given(:token_param) { 'not token' }
      Given(:confirmed_at) { nil }

      Then { expect(page).to have_text 'Invalid URL' }
      And { expect(page).to have_current_path root_path }
      And { !email_address.confirmed? }
      And { email_address.confirmed_at.nil? }
    end
  end

  describe "requesting a new confirmation email" do
    When { visit new_email_address_confirmation_resend_path(email_address_id: email_address.id) }

    context "when email has not yet been confirmed" do
      Given(:confirmed_at) { nil }
      Then { PrimaryEmailAddressConfirmationWorker.jobs.one? }
    end

    context "when email has already been confirmed" do
      Given(:confirmed_at) { 1.year.ago }
      Then { PrimaryEmailAddressConfirmationWorker.jobs.none? }
    end
  end

end
