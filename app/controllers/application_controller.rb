class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  default_form_builder DiffAlertFormBuilder
  include SessionsHelper

end
