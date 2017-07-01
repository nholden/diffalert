class TriggerFormDecorator < Draper::Decorator

  def email_selectize_items
    [object.email_address_address].compact.to_json.html_safe
  end

  def email_selectize_options
    ([current_email_selectize_data] + non_current_emails_selectize_data).compact.to_json.html_safe
  end

  def slack_webhook_selectize_items
    [object.slack_webhook_url].compact.to_json.html_safe
  end

  def slack_webhook_selectize_options
    ([current_slack_webhook_selectize_data] + non_current_slack_webhook_selectize_data).compact.to_json.html_safe
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

  def current_slack_webhook_selectize_data
    return unless object.slack_webhook_url.present?

    if current_slack_webhook = object.user.slack_webhooks.find_by_url(object.slack_webhook_url)
      current_slack_webhook.decorate.selectize_data
    else
      { value: object.slack_webhook_url }
    end
  end

  def non_current_slack_webhook_selectize_data
    object.user.slack_webhooks.map do |slack_webhook|
      unless slack_webhook.url == object.slack_webhook_url
        slack_webhook.decorate.selectize_data
      end
    end
  end

end
