require 'rails_helper'

RSpec.describe UserConfirmationEmailWorker do

  Given(:user) { FactoryGirl.create(:user, email: 'new@user.com') }
  Given(:email) { ActionMailer::Base.deliveries.last }
  Given(:email_body) { convert_to_text(email.html_part.to_s) }
  Given { ActionMailer::Base.deliveries.clear }

  describe "perform" do
    When { UserConfirmationEmailWorker.new.perform(user.id) }

    Then { ActionMailer::Base.deliveries.one? }
    And { expect(email.to).to match_array(['new@user.com']) }
    And { email.subject == 'Confirm your email address' }
    And { email_body =~ /Thanks for signing up for DiffAlert!/ }
    And { email_body =~ /Confirm your email address/ }
  end

end
