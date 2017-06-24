class ConfirmationEmailResendsController < ApplicationController

  def new
    user = User.find(params[:user_id])

    if user.email_confirmed?
      flash[:notice] = "You have already confirmed #{user.email}."
    else
      UserConfirmationEmailWorker.perform_async(user.id)
      flash[:notice] = "Confirmation email resent to #{user.email}."
    end

    redirect_back fallback_location: root_path
  end

end
