require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "triggers" do

  Given(:user) { FactoryGirl.create(:user) }

  context "authenticated" do
    When { log_in_as user }
    When { visit triggers_path }

    Then { expect(page).to have_content user.email }

    describe "creating a new Trigger" do
      When { click_link 'Add trigger' }
      When { fill_in 'Repository', with: 'sandbox' }
      When { fill_in 'Branch', with: 'master' }
      When { fill_in 'Filename', with: 'README.md' }
      When { fill_in 'Email', with: 'qwerty@slack.com' }
      When { fill_in 'Message', with: 'README.md changed!' }
      When { click_button 'Create trigger' }

      Then { expect(page).to have_content 'New trigger created!' }
      And { expect(page).to have_content 'sandbox' }
      And { expect(page).to have_content 'master' }
      And { expect(page).to have_content 'README.md' }

      And { user.triggers.last.repository_name == 'sandbox' }
      And { user.triggers.last.branch == 'master' }
      And { user.triggers.last.modified_file == 'README.md' }
      And { user.triggers.last.email == 'qwerty@slack.com' }
      And { user.triggers.last.message == 'README.md changed!' }
    end

    describe "deleting a Trigger" do
      Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

      When { log_in_as user }
      When { click_link 'Delete' }

      Then { expect(page).to have_content 'Trigger deleted.' }
      And { expect(page).to_not have_content(trigger.modified_file) }
      And { !Trigger.find_by_id(trigger.id) }
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
