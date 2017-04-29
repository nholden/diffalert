require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "triggers" do

  Given(:user) { FactoryGirl.create(:user) }

  context "authenticated" do
    When { log_in_as user }
    When { visit triggers_path }

    Then { expect(page).to have_content user.email }

    describe "deleting a Trigger" do
      Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

      When { click_link 'Delete' }

      Then { expect(page).to have_content 'Trigger deleted.' }
      And { expect(page).to_not have_content(trigger.modified_file) }
      And { !Trigger.find_by_id(trigger.id) }
    end

    describe "editing a Trigger" do
      Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

      When { click_link 'Edit' }
      When { fill_in 'Branch', with: 'staging' }
      When { click_button 'Save trigger' }
      When { trigger.reload }

      Then { expect(page).to have_content 'Trigger updated.' }
      And { expect(page).to have_content 'staging' }
      And { trigger.branch == 'staging' }
    end

    describe "viewing triggers" do
      Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

      context "when Trigger has an Alert" do
        Given!(:alert) { FactoryGirl.create(:alert, trigger: trigger, created_at: 3.hours.ago) }

        Then { expect(page).to have_content 'about 3 hours ago' }
      end

      context "when Trigger does not have an Alert" do
        Then { expect(page).to have_content 'Never' }
      end
    end
  end

  context "not authenticated" do
    When { visit triggers_path }

    Then { expect(page).to_not have_content user.email }
    And { expect(page).to have_content 'You must be logged in to view that page' }
  end

end
