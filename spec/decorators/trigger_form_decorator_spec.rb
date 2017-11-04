require 'rails_helper'

RSpec.describe TriggerFormDecorator do

  Given(:trigger_form) { TriggerForm.new }
  Given(:decorator) { trigger_form.decorate }

  describe "#email_selectize_items" do
    When(:result) { decorator.email_selectize_items }

    context "when email_address_address is nil" do
      Given { trigger_form.email_address_address = nil }
      Then { result == [].to_json }
    end

    context "when email_address_address is present" do
      Given { trigger_form.email_address_address = 'woah@hey.yo' }
      Then { result == ['woah@hey.yo'].to_json }
    end
  end

  describe "#email_selectize_options" do
    Given { trigger_form.user = user }
    Given(:user) { FactoryBot.create(:user) }
    Given { FactoryBot.create(:email_address, :alert, user: user, address: 'zoinks@bloop.net', name: 'Zoinks personal') }

    When(:result) { decorator.email_selectize_options }

    context "when email_address_address is nil" do
      Given { trigger_form.email_address_address = nil }

      Then { result == [
        { value: user.primary_email_address.address },
        { value: 'zoinks@bloop.net', text: 'Zoinks personal' }
      ].to_json }
    end

    context "when email_address_address is present" do
      Given { trigger_form.email_address_address = 'woah@hey.yo' }

      Then { result == [
        { value: 'woah@hey.yo' },
        { value: user.primary_email_address.address },
        { value: 'zoinks@bloop.net', text: 'Zoinks personal' },
      ].to_json }
    end

    context "when email_address_address matches an existing email_address" do
      Given { trigger_form.email_address_address = 'zoinks@bloop.net' }

      Then { result == [
        { value: 'zoinks@bloop.net', text: 'Zoinks personal' },
        { value: user.primary_email_address.address },
      ].to_json }
    end
  end

  describe "#slack_webhook_selectize_items" do
    When(:result) { decorator.slack_webhook_selectize_items }

    context "when slack_webhook_url is nil" do
      Given { trigger_form.slack_webhook_url = nil }
      Then { result == [].to_json }
    end

    context "when slack_webhook_url is present" do
      Given { trigger_form.slack_webhook_url = 'https://hooks.slack.com/services/WOAH' }
      Then { result == ['https://hooks.slack.com/services/WOAH'].to_json }
    end
  end

  describe "#slack_webhook_selectize_options" do
    Given { trigger_form.user = user }
    Given(:user) { FactoryBot.create(:user) }
    Given { FactoryBot.create(:slack_webhook, user: user, url: 'https://hooks.slack.com/services/BEEPBOOP', name: '#watercooler') }

    When(:result) { decorator.slack_webhook_selectize_options }

    context "when slack_webhook_url is nil" do
      Given { trigger_form.slack_webhook_url = nil }

      Then { result == [
        { value: 'https://hooks.slack.com/services/BEEPBOOP', text: '#watercooler' },
      ].to_json }
    end

    context "when slack_webhook_url is present" do
      Given { trigger_form.slack_webhook_url = 'https://hooks.slack.com/services/BORK' }

      Then { result == [
        { value: 'https://hooks.slack.com/services/BORK' },
        { value: 'https://hooks.slack.com/services/BEEPBOOP', text: '#watercooler' },
      ].to_json }
    end

    context "when email_address_address matches an existing email_address" do
      Given { trigger_form.slack_webhook_url = 'https://hooks.slack.com/services/BEEPBOOP' }

      Then { result == [
        { value: 'https://hooks.slack.com/services/BEEPBOOP', text: '#watercooler' },
      ].to_json }
    end
  end

end
