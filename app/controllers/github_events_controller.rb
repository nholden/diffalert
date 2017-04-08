class GithubEventsController < ApplicationController

  def create
    render json: { status: 'Success' }
  end

end
