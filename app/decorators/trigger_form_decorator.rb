class TriggerFormDecorator < Draper::Decorator

  def email_selectize_items
    [object.email_address_address].compact.to_json.html_safe
  end

  def email_selectize_options
    ([current_email_selectize_data] + non_current_emails_selectize_data).compact.to_json.html_safe
  end

  private

  def current_email_selectize_data
    return unless object.email_address_address.present?

    if current_email_address = object.user.email_addresses.find_by_address(object.email_address_address)
      current_email_address.decorate.selectize_data
    else
      { value: object.email_address_address }
    end
  end

  def non_current_emails_selectize_data
    object.user.email_addresses.map do |email_address|
      unless email_address.address == object.email_address_address
        email_address.decorate.selectize_data
      end
    end
  end

end
