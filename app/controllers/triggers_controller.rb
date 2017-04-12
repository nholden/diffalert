class TriggersController < ApplicationController

  include RequiresSignIn

  expose :trigger

  def index
  end

  def new
    @trigger = Trigger.new
  end

  def create
    @trigger = Trigger.new(trigger_params) do |trigger|
      trigger.user = current_user
    end

    if @trigger.save
      flash[:notice] = 'New trigger created!'
      redirect_to triggers_path
    else
      render 'new'
    end
  end

  def destroy
    trigger.destroy!
    flash[:notice] = 'Trigger deleted.'
    redirect_to triggers_path
  end

  private

  def trigger_params
    params.require(:trigger).permit(:repository_name, :branch, :modified_file, :email, :message)
  end

end
