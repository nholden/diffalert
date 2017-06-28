class SessionsController < ApplicationController

  def new
    redirect_to triggers_path if current_user
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "Welcome back, #{user.username}!"
      redirect_to triggers_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end

end
