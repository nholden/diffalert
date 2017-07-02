class TriggerDecorator < Draper::Decorator

  delegate_all

  def branch
    object.branch || 'All branches'
  end

  def modified_file
    object.modified_file || 'All files'
  end

  def last_alert_time_ago
    if object.alerts.any?
      "#{h.time_ago_in_words(object.recent_alert.created_at)} ago"
    else
      'Never'
    end
  end

end
