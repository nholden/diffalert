require 'rails_helper'

RSpec.describe TriggerForm, type: :model do

  Given(:default_attrs) { {
    modified_file: "todo.md",
    email_address_address: "test@gmail.com",
    slack_webhook_url: "https://hooks.slack.com/services/FOO/BAR/FOOBAR",
    message: "Hello world!",
    branch: "master",
    repository_name: "sandbox",
  } }

  describe "validations" do
    Given(:trigger_form) { TriggerForm.new(default_attrs) }

    describe "modified_file" do
      Given { trigger_form.modified_file = modified_file }

      context "it is valid with a modified file" do
        When(:modified_file) { 'abc.rb' }
        Then { trigger_form.valid? }
      end

      context "it is invalid a blank modified file" do
        When(:modified_file) { ' ' }
        Then { !trigger_form.valid? }
      end
    end

    describe "message" do
      Given { trigger_form.message = message }

      context "it is valid with a message" do
        When(:message) { 'Important file was updated!' }
        Then { trigger_form.valid? }
      end

      context "it is invalid with a blank message" do
        When(:message) { ' ' }
        Then { !trigger_form.valid? }
      end
    end

    describe "email_address_address and slack_webhook_url" do
      Given { trigger_form.email_address_address = email_address_address }
      Given { trigger_form.slack_webhook_url = slack_webhook_url }

      context "it is valid with a valid email_address_address" do
        When(:email_address_address) { 'tony.gwynn@padres.com' }
        When(:slack_webhook_url) { '' }

        Then { trigger_form.valid? }
      end

      context "it is invalid with an invalid email_address_address" do
        When(:email_address_address) { 'tony.gwynn@padres' }
        When(:slack_webhook_url) { '' }

        Then { !trigger_form.valid? }
      end

      context "it is valid with a valid slack_webhook_url" do
        When(:email_address_address) { '' }
        When(:slack_webhook_url) { 'https://hooks.slack.com/services/foo/bar' }

        Then { trigger_form.valid? }
      end

      context "it is invalid with an invalid slack_webhook_url" do
        When(:email_address_address) { '' }
        When(:slack_webhook_url) { 'https://hooks.google.com/services/foo/bar' }

        Then { !trigger_form.valid? }
      end

      context "it is invalid with a blank email_address_address and a blank slack_webhook_url" do
        When(:email_address_address) { ' ' }
        When(:slack_webhook_url) { ' ' }

        Then { !trigger_form.valid? }
      end
    end

    describe "branch" do
      Given { trigger_form.branch = branch }

      context "it is valid with a branch" do
        When(:branch) { 'master' }
        Then { trigger_form.valid? }
      end

      context "it is invalid a blank branch" do
        When(:branch) { ' ' }
        Then { !trigger_form.valid? }
      end
    end

    describe "repository_name" do
      Given { trigger_form.repository_name = repository_name }

      context "it is valid with a repository name" do
        When(:repository_name) { 'sandbox' }
        Then { trigger_form.valid? }
      end

      context "it is invalid with a blank repository name" do
        When(:repository_name) { ' ' }
        Then { !trigger_form.valid? }
      end
    end
  end

  describe "#save!" do
    Given(:trigger_form) { TriggerForm.new(default_attrs.merge({ trigger: trigger, user: trigger.user, email_address: email_address })) }
    Given(:trigger) { FactoryGirl.create(:trigger, email_address: email_address) }
    Given(:email_address) { FactoryGirl.create(:email_address, :alert, name: 'Gmail') }

    When { trigger_form.save! }
    When { email_address.reload }

    context "when email_address_name is present, it updates the email address's name" do
      Given { trigger_form.email_address_name = 'Yahoo' }
      Then { email_address.name == 'Yahoo' }
    end

    context "when email_address_name is blank, it does not update the email address's name" do
      Given { trigger_form.email_address_name = ' ' }
      Then { email_address.name == 'Gmail' }
    end
  end

end
