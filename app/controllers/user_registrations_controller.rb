class UserRegistrationsController < ApplicationController

  def new
    @user_registration = UserRegistration.new
  end

  def create
    @user_registration = UserRegistration.new(user_registration_params)

    if @user_registration.valid?
      @user_registration.save!
      log_in @user_registration.user
      flash[:notice] = 'You&rsquo;re signed up!'
      redirect_to triggers_path
    else
      render 'new'
    end
  end

  private

  def user_registration_params
    params.require(:user_registration).permit(:email, :password, :password_confirmation)
  end

end
