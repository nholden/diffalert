class DiffAlertFormBuilder < ActionView::Helpers::FormBuilder

  def error_messages(attribute)
    if errors = object.errors[attribute].join(', ').presence
      @template.content_tag :div, "This field #{errors}.", class: 'error-message'
    end
  end

end
