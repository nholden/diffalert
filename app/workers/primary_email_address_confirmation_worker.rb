class PrimaryEmailAddressConfirmationWorker

  include Sidekiq::Worker

  def perform(email_address_id)
    email_address = EmailAddress.find(email_address_id)
    ConfirmationMailer.primary_email_address(email_address).deliver
  end

end
