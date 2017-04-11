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
    event = Github::PushEvent.new(request.params)

    event.modified_files.each do |modified_file|
      if trigger = user.triggers.where(modified_file: modified_file, branch: event.branch).last
        trigger.alerts.create!
      end
    end
  end

end
