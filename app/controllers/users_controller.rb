class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) do |user|
      user.github_events_secret = SecureRandom.hex(20)
    end

    if @user.save
      log_in @user
      flash[:notice] = 'You&rsquo;re signed up!'
      redirect_to user_triggers_path(@user)
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
