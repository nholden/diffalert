require 'rails_helper'

RSpec.describe AlertWorker do

  Given(:alert) { FactoryGirl.create(:alert, email: email, slack_webhook_url: slack_webhook_url) }
  Given(:emails) { ActionMailer::Base.deliveries }
  Given(:slack_messages) { SlackInterceptor.messages }
  Given { ActionMailer::Base.deliveries.clear && SlackInterceptor.messages.clear }

  describe "perform" do
    When { AlertWorker.new.perform(alert.id) }

    context "when alert has an email" do
      Given(:email) { 'nick@diffalert.com' }
      Given(:slack_webhook_url) { nil }

      Then { emails.one? }
      And { expect(emails.last.to).to match_array([email]) }
      And { slack_messages.none? }
    end

    context "when alert has a slack_webhook_url" do
      Given(:email) { nil }
      Given(:slack_webhook_url) { 'https://hooks.slack.com/services/FOO/BAR/FOOBAR' }

      Then { emails.none? }
      And { slack_messages.one? }
      And { slack_messages.last.webhook_url == slack_webhook_url }
    end

    context "when alert has both an email and a slack_webhook_url" do
      Given(:email) { 'nick@diffalert.com' }
      Given(:slack_webhook_url) { 'https://hooks.slack.com/services/FOO/BAR/FOOBAR' }

      Then { emails.one? }
      And { expect(emails.last.to).to match_array([email]) }
      And { slack_messages.one? }
      And { slack_messages.last.webhook_url == slack_webhook_url }
    end
  end

end
