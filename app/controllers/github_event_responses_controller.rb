class GithubEventResponsesController < ApplicationController

  skip_before_action :verify_authenticity_token
  expose :user

  def create
    if valid_signature?
      create_alerts!
      render json: { message: 'Success' }, status: 200
    else
      render json: { message: 'Invalid secret' }, status: 401
    end
  end

  private

  def valid_signature?
    expected_signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), user.github_events_secret, request.body.read)
    ActiveSupport::SecurityUtils.secure_compare(expected_signature, request.env['HTTP_X_HUB_SIGNATURE'])
  end

  def create_alerts!
    user.triggers.for_event(Github::PushEvent.new(request.params)).each do |trigger|
      trigger.alerts.create!(
        email: trigger.email,
        slack_webhook_url: trigger.slack_webhook_url,
        message: trigger.message
      )
    end
  end

end
