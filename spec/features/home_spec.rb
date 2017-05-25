require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "home" do

  Given(:user) { FactoryGirl.create(:user) }

  context "authenticated" do
    When { log_in_as user }
    When { visit root_path }

    Then { expect(page).to have_content 'Your triggers' }
    And { expect(page).to_not have_content 'Custom email and Slack alerts for your GitHub repositories' }
  end

  context "not authenticated" do
    When { visit root_path }

    Then { expect(page).to have_content 'Custom email and Slack alerts for your GitHub repositories' }
    And { expect(page).to_not have_content 'Your triggers' }
  end

end
