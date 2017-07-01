class TriggersController < ApplicationController

  include RequiresSignIn

  expose :triggers, -> {
    current_user.
      triggers.
      left_outer_joins(:recent_alert).
      order('lower(triggers.repository_name) ASC, alerts.created_at DESC').
      decorate
  }

  def index
  end

  def destroy
    current_user.triggers.find(params[:id]).destroy!
    flash[:notice] = 'Trigger deleted.'
    redirect_to triggers_path
  end

end
