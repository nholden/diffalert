class TriggerFormDecorator < Draper::Decorator

  def email_selectize_items
    [object.email_address_address].compact.to_json.html_safe
  end

  def email_selectize_options
    [].tap do |result|
      if current_address = object.email_address_address.presence
        result << { value: current_address, text: current_address }
      end

      object.user.email_addresses.pluck(:address).each do |address|
        result << { value: address, text: address }
      end
    end.to_json.html_safe
  end

end
