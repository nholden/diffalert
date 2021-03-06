require 'rails_helper'
require 'support/authentication_helper'
require 'support/trigger_form_helper'

RSpec.describe "triggers" do

  Given(:user) { FactoryBot.create(:user) }

  context "authenticated" do
    When { log_in_as user }
    When { visit triggers_path }

    describe "creating a new Trigger" do
      Given(:trigger) { user.triggers.last }
      Given(:email_address) { trigger.email_address }
      Given(:slack_webhook) { trigger.slack_webhook }

      When { click_link 'Create your first trigger' }
      When { fill_in_trigger_form }
      When { click_button 'Save trigger' }

      Then { expect(page).to have_content 'New trigger created!' }
      And { expect(page).to have_content 'Configure your alerts in GitHub' }
      And { expect(page).to have_content "Payload URL http://www.example.com/users/#{user.id}/github" }
      And { expect(page).to have_content 'Content type application/json' }
      And { expect(page).to have_content "Secret #{user.github_events_secret}" }
      And { expect(page).to have_content 'Which events would you like to trigger this webhook? Just the push event' }

      And { trigger.repository_name == 'sandbox' }
      And { trigger.branch == 'master' }
      And { trigger.modified_path == 'README.md' }
      And { trigger.message == 'README.md changed!' }

      And { email_address.address == 'qwerty@slack.com' }
      And { email_address.name == 'Qwerty work' }
      And { email_address.address_type = EmailAddress::ALERT_TYPE }
      And { email_address.confirmation_token.present? }
      And { email_address.confirmed_at.nil? }

      And { slack_webhook.url == 'https://hooks.slack.com/services/FOO/BAR/FOOBAR' }
      And { slack_webhook.name == '#general' }
    end

    describe "creating a new Trigger for all branches" do
      Given(:trigger) { user.triggers.last }

      When { click_link 'Create your first trigger' }
      When { fill_in_trigger_form }
      When { choose 'All branches' }
      When { click_button 'Save trigger' }

      Then { trigger.branch.nil? }
    end

    describe "creating a new Trigger for all modified files" do
      Given(:trigger) { user.triggers.last }

      When { click_link 'Create your first trigger' }
      When { fill_in_trigger_form }
      When { choose 'All files' }
      When { click_button 'Save trigger' }

      Then { trigger.modified_path.nil? }
    end

    describe "deleting a Trigger" do
      Given!(:trigger) { FactoryBot.create(:trigger, user: user) }

      When { click_link 'ⓧ' }

      Then { expect(page).to have_content 'Trigger deleted.' }
      And { expect(page).to_not have_content(trigger.modified_path) }
      And { !Trigger.find_by_id(trigger.id) }
    end

    describe "editing a Trigger" do
      Given!(:trigger) { FactoryBot.create(:trigger, user: user) }

      When { click_link '✎' }
      When { fill_in 'Branch', with: 'staging' }
      When { click_button 'Save trigger' }
      When { trigger.reload }

      Then { expect(page).to have_content 'Trigger updated.' }
      And { expect(page).to have_content 'staging' }
      And { trigger.branch == 'staging' }
    end

    describe "viewing triggers" do
      context "when no triggers exist" do
        Then { expect(page).to have_content 'You don’t have any triggers yet! Create your first trigger.' }
      end

      context "when a Trigger exists" do
        Given!(:trigger) { FactoryBot.create(:trigger, user: user) }

        context "when Trigger has an Alert" do
          around(:each) do |example|
            VCR.use_cassette('slack/message/send') { example.run }
          end

          Given!(:alert) { FactoryBot.create(:alert, trigger: trigger, created_at: 3.hours.ago) }

          Then { expect(page).to have_content 'about 3 hours ago' }
        end

        context "when Trigger does not have an Alert" do
          Then { expect(page).to have_content 'Never' }
        end
      end
    end
  end

  context "not authenticated" do
    When { visit triggers_path }

    Then { expect(page).to_not have_content user.username }
    And { expect(page).to have_content 'You must be logged in to view that page' }
  end

end
