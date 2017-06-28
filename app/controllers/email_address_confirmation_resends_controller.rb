class EmailAddressConfirmationResendsController < ApplicationController

  def new
    email_address = EmailAddress.find(params[:email_address_id])

    if email_address.confirmed?
      flash[:notice] = "You have already confirmed #{email_address.address}."
    else
      PrimaryEmailAddressConfirmationWorker.perform_async(email_address.id)
      flash[:notice] = "Confirmation email resent to #{email_address.address}."
    end

    redirect_back fallback_location: root_path
  end

end
