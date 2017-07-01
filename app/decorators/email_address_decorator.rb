class EmailAddressDecorator < Draper::Decorator

  delegate_all

  def confirmation_url
    h.new_email_address_confirmation_url(email_address_id: object.id, token: object.confirmation_token)
  end

  def selectize_data
    {}.tap do |result|
      result[:value] = object.address

      if object.name.present?
        result[:text ] = object.name
      end
    end
  end

end
