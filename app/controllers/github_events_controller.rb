class GithubEventsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    if user = User.find_by_github_events_secret(request.headers['X-Hub-Signature'])
      render json: { message: 'Success' }, status: 200

      request.params.dig(:commits, :modified).each do |modified_file|
        if trigger = user.triggers.find_by_modified_file(modified_file)
          trigger.alerts.create
        end
      end
    else
      render json: { message: 'Cannot find user with that secret' }, status: 401
    end
  end

end
