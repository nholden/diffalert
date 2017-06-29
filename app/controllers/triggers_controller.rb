class TriggersController < ApplicationController

  include RequiresSignIn

  expose :trigger, -> { current_user.triggers.find(params[:id]) }

  def index
  end

  def destroy
    trigger.destroy!
    flash[:notice] = 'Trigger deleted.'
    redirect_to triggers_path
  end

end
