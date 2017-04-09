class TriggersController < ApplicationController

  # TODO: require authenticated user

  expose :user
  expose :trigger

  def index
  end

  def new
    @trigger = Trigger.new
  end

  def create
    @trigger = Trigger.new(trigger_params) do |trigger|
      trigger.user = user
    end

    if @trigger.save
      flash[:notice] = 'New trigger created!'
      redirect_to user_triggers_path(user)
    else
      render new_user_trigger_path(user)
    end
  end

  def destroy
    trigger.destroy!
    flash[:notice] = 'Trigger deleted.'
    redirect_to user_triggers_path(user)
  end

  private

  def trigger_params
    params.require(:trigger).permit(:modified_file, :email, :message)
  end

end
