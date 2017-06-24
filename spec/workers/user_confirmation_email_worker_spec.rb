require 'rails_helper'
include Premailer::HtmlToPlainText

RSpec.describe UserConfirmationEmailWorker do

  Given(:user) { FactoryGirl.create(:user, email: 'new@user.com') }
  Given(:email) { ActionMailer::Base.deliveries.last }
  Given { ActionMailer::Base.deliveries.clear }

  describe "perform" do
    When { UserConfirmationEmailWorker.new.perform(user.id) }

    Then { ActionMailer::Base.deliveries.one? }
    And { expect(email.to).to match_array(['new@user.com']) }
    And { email.subject == 'Confirm your email address' }
    And { convert_to_text(email.body.to_s) =~ /You’re signed up for DiffAlert!/ }
  end

end
