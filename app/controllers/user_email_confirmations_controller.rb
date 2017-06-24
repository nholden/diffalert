class UserEmailConfirmationsController < ApplicationController

  def show
    user = User.find(params[:user_id])

    if user.email_confirmation_token == params[:token]
      if user.email_confirmed?
        flash[:notice] = "You have already confirmed #{user.email}."
      else
        user.confirm_email!
        flash[:notice] = "Thank you! You have confirmed #{user.email}."
      end

      redirect_to new_session_path
    else
      flash[:alert] = "Invalid URL"
      redirect_to root_path
    end
  end

end
