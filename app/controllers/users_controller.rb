class UsersController < ApplicationController

  expose :user

  def new
  end

  def create
    if user = User.create(user_params)
      flash[:notice] = 'You&rsquo;re signed up!'
      redirect_to user_triggers_path(user)
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
