class UserEmailConfirmationsController < ApplicationController

  def new
    user = User.find(params[:user_id])

    if user.email_confirmation_token == params[:token]
      if user.email_confirmed?
        flash[:notice] = "You have already confirmed #{user.email}."
      else
        user.confirm_email!
        flash[:notice] = "Thank you! You have confirmed #{user.email}."
      end
    else
      flash[:alert] = "Invalid URL"
    end

    redirect_to root_path
  end

end
