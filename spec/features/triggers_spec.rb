require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "triggers" do

  describe "viewing the triggers page" do
    Given(:user) { FactoryGirl.create(:user) }

    context "authenticated" do
      When { log_in_as user }
      When { visit triggers_path }

      Then { expect(page).to have_content user.email }
    end

    context "not authenticated" do
      When { visit triggers_path }

      Then { expect(page).to_not have_content user.email }
      And { expect(page).to have_content 'You must be logged in to view that page' }
    end
  end

  describe "creating a new trigger" do
    Given(:user) { FactoryGirl.create(:user) }

    When { log_in_as user }
    When { click_link 'Add trigger' }
    When { fill_in 'Repository', with: 'sandbox' }
    When { fill_in 'Branch', with: 'master' }
    When { fill_in 'Filename', with: 'README.md' }
    When { fill_in 'Email', with: 'qwerty@slack.com' }
    When { fill_in 'Message', with: 'README.md changed!' }
    When { click_button 'Create trigger' }

    Then { expect(page).to have_content 'New trigger created!' }
    And { expect(page).to have_content 'When README.md changes on the master branch of sandbox, send an email to qwerty@slack.com saying “README.md changed!”' }
    And { user.triggers.last.modified_file == 'README.md' }
    And { user.triggers.last.email == 'qwerty@slack.com' }
    And { user.triggers.last.message == 'README.md changed!' }
  end

  describe "deleting a trigger" do
    Given(:user) { FactoryGirl.create(:user) }
    Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

    When { log_in_as user }
    When { click_link 'Delete' }

    Then { expect(page).to have_content 'Trigger deleted.' }
    And { expect(page).to_not have_content(trigger.modified_file) }
    And { !Trigger.find_by_id(trigger.id) }
  end

  describe "viewing the last alert for a Trigger" do
    Given(:user) { FactoryGirl.create(:user) }
    Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

    When { log_in_as user }

    context "when Trigger has an alert" do
      Given!(:alert) { FactoryGirl.create(:alert, trigger: trigger, created_at: 3.hours.ago) }

      Then { expect(page).to have_content 'Last alert was about 3 hours ago.' }
    end

    context "when Trigger does not have an alert" do
      Then { expect(page).to have_content 'This trigger has never created an alert.' }
    end
  end

end
