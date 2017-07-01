require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "triggers" do

  Given(:user) { FactoryGirl.create(:user) }

  context "authenticated" do
    When { log_in_as user }
    When { visit triggers_path }

    describe "creating a new Trigger" do
      Given(:trigger) { user.triggers.last }
      Given(:email_address) { trigger.email_address }
      Given(:slack_webhook) { trigger.slack_webhook }

      When { click_link 'Add trigger' }

      When { fill_in 'Paste the GitHub link to the file you’d like to monitor',
             with: 'https://github.com/nholden/sandbox/blob/other-branch/README.md' }
      When { click_button 'Next' }

      When { fill_in 'Branch', with: 'master' }
      When { fill_in 'Email', with: 'qwerty@slack.com' }
      When { fill_in 'Name this email', with: 'Qwerty work' }
      When { fill_in 'Slack webhook URL', with: 'https://hooks.slack.com/services/FOO/BAR/FOOBAR' }
      When { fill_in 'Name this Slack webhook', with: '#general' }
      When { fill_in 'Message', with: 'README.md changed!' }
      When { click_button 'Save trigger' }

      Then { expect(page).to have_content 'New trigger created!' }
      And { expect(page).to have_content 'Configure your alerts in GitHub' }
      And { expect(page).to have_content "Payload URL http://www.example.com/users/#{user.id}/github" }
      And { expect(page).to have_content 'Content type application/json' }
      And { expect(page).to have_content "Secret #{user.github_events_secret}" }
      And { expect(page).to have_content 'Which events would you like to trigger this webhook? Just the push event' }

      And { trigger.repository_name == 'sandbox' }
      And { trigger.branch == 'master' }
      And { trigger.modified_file == 'README.md' }
      And { trigger.message == 'README.md changed!' }

      And { email_address.address == 'qwerty@slack.com' }
      And { email_address.name == 'Qwerty work' }
      And { email_address.address_type = EmailAddress::ALERT_TYPE }
      And { email_address.confirmation_token.present? }
      And { email_address.confirmed_at.nil? }

      And { slack_webhook.url == 'https://hooks.slack.com/services/FOO/BAR/FOOBAR' }
      And { slack_webhook.name == '#general' }
    end

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
        around(:each) do |example|
          VCR.use_cassette('slack/message/send') { example.run }
        end

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

    Then { expect(page).to_not have_content user.username }
    And { expect(page).to have_content 'You must be logged in to view that page' }
  end

end
