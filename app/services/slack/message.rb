require 'excon'

module Slack
  class Message

    def initialize(webhook_url:, content:)
      @webhook_url = webhook_url
      @content = content
    end

    def send!
      Excon.post(@webhook_url,
                 body: { text: @content }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
    end

  end
end
