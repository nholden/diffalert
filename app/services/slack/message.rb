require 'excon'

module Slack
  class Message

    attr_reader :webhook_url, :content

    def initialize(webhook_url:, content:)
      @webhook_url = webhook_url
      @content = content
    end

    def send!
      if Rails.env.test?
        SlackInterceptor.messages << self
      else
        Rails.logger.info "[Slack::Message] Sending \"#{content}\" to #{webhook_url}"
        Excon.post(webhook_url,
                   body: { text: content }.to_json,
                   headers: { 'Content-Type' => 'application/json' })
      end
    end

  end
end
