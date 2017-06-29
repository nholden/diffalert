require 'rails_helper'

RSpec.describe TriggerForm, type: :model do

  describe "validations" do
    Given(:trigger_form) {
      TriggerForm.new(
        modified_file: "todo.md",
        email: "test@gmail.com",
        slack_webhook_url: "https://hooks.slack.com/services/FOO/BAR/FOOBAR",
        message: "Hello world!",
        branch: "master",
        repository_name: "sandbox",
      )
    }

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

    describe "email and slack_webhook_url" do
      Given { trigger_form.email = email }
      Given { trigger_form.slack_webhook_url = slack_webhook_url }

      context "it is valid with a valid email" do
        When(:email) { 'tony.gwynn@padres.com' }
        When(:slack_webhook_url) { '' }

        Then { trigger_form.valid? }
      end

      context "it is invalid with an invalid email" do
        When(:email) { 'tony.gwynn@padres' }
        When(:slack_webhook_url) { '' }

        Then { !trigger_form.valid? }
      end

      context "it is valid with a valid slack_webhook_url" do
        When(:email) { '' }
        When(:slack_webhook_url) { 'https://hooks.slack.com/services/foo/bar' }

        Then { trigger_form.valid? }
      end

      context "it is invalid with an invalid slack_webhook_url" do
        When(:email) { '' }
        When(:slack_webhook_url) { 'https://hooks.google.com/services/foo/bar' }

        Then { !trigger_form.valid? }
      end

      context "it is invalid with a blank email and a blank slack_webhook_url" do
        When(:email) { ' ' }
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

end
