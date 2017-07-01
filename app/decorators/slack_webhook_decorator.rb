class SlackWebhookDecorator < Draper::Decorator

  delegate_all

  def selectize_data
    {}.tap do |result|
      result[:value] = object.url

      if object.name.present?
        result[:text] = object.name
      end
    end
  end

end
