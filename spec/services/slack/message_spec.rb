require 'rails_helper'

RSpec.describe Slack::Message do

  describe "#send!" do
    around(:each) do |example|
      VCR.use_cassette('slack/message/send') { example.run }
    end

    Given(:message) { Slack::Message.new(webhook_url: webhook_url, content: content) }
    Given(:webhook_url) { 'https://hooks.slack.com/services/FOO/BAR/FOOBAR' }
    Given(:content) { 'Hello world!' }

    When(:result) { message.send! }

    Then { result.status == 200 }
    And { result.body == 'ok' }
  end

end
