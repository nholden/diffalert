class TriggersController < ApplicationController

  include RequiresSignIn

  expose :triggers, -> { current_user.triggers.order('lower(repository_name)').decorate }

  def index
  end

  def destroy
    current_user.triggers.find(params[:id]).destroy!
    flash[:notice] = 'Trigger deleted.'
    redirect_to triggers_path
  end

end
