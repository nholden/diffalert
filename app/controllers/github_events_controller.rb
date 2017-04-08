class GithubEventsController < ApplicationController

  def create
    if User.find_by_github_events_secret(request.headers['X-Hub-Signature'])
      render json: { message: 'Success' }, status: 200
    else
      render json: { message: 'Cannot find user with that secret' }, status: 401
    end
  end

end
