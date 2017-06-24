class UserDecorator < Draper::Decorator

  delegate_all

  def email_confirmation_url
    h.new_user_email_confirmation_url(user_id: object.id, token: object.email_confirmation_token)
  end

  def github_event_payload_url
    h.user_github_event_responses_url(object)
  end

end
