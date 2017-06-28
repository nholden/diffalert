class EmailAddressDecorator < Draper::Decorator

  delegate_all

  def confirmation_url
    h.new_email_address_confirmation_url(email_address_id: object.id, token: object.confirmation_token)
  end

end
