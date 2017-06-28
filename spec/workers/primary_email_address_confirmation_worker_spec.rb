require 'rails_helper'

RSpec.describe PrimaryEmailAddressConfirmationWorker do

  Given(:email_address) { FactoryGirl.create(:email_address, address: 'new@user.com') }
  Given(:message) { ActionMailer::Base.deliveries.last }
  Given(:message_body) { convert_to_text(message.html_part.to_s) }
  Given { ActionMailer::Base.deliveries.clear }

  describe "perform" do
    When { PrimaryEmailAddressConfirmationWorker.new.perform(email_address.id) }

    Then { ActionMailer::Base.deliveries.one? }
    And { expect(message.to).to match_array(['new@user.com']) }
    And { message.subject == 'Confirm your email address' }
    And { message_body =~ /Thanks for signing up for DiffAlert!/ }
    And { message_body =~ /Confirm your email address/ }
  end

end
