class EmailAddressConfirmationsController < ApplicationController

  def new
    email_address = EmailAddress.find(params[:email_address_id])

    if email_address.confirmation_token == params[:token]
      if email_address.confirmed?
        flash[:notice] = "You have already confirmed #{email_address.address}."
      else
        email_address.confirm!
        flash[:notice] = "Thank you! You have confirmed #{email_address.address}."
      end
    else
      flash[:alert] = "Invalid URL"
    end

    redirect_to root_path
  end

end
