class TriggersController < ApplicationController

  include RequiresSignIn

  expose :trigger, -> { current_user.triggers.find(params[:id]) }

  def index
  end

  def new
    @trigger = Trigger.new(trigger_params)
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

  def edit
  end

  def update
    if trigger.update_attributes(trigger_params)
      flash[:notice] = 'Trigger updated.'
      redirect_to triggers_path
    else
      render 'edit'
    end
  end

  private

  def trigger_params
    params.require(:trigger).permit(:repository_name, :branch, :modified_file, :email, :message)
  end

end
