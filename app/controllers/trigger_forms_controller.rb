class TriggerFormsController < ApplicationController

  include RequiresSignIn

  expose :trigger, -> { current_user.triggers.find(params[:trigger_id]) }

  def new
    @trigger_form = TriggerForm.new(trigger_form_params)
  end

  def create
    @trigger_form = TriggerForm.new(trigger_form_params)
    @trigger_form.user = current_user

    if @trigger_form.valid?
      @trigger_form.save!
      flash[:notice] = 'New trigger created!'
      redirect_to trigger_setup_instructions_path
    else
      render 'new'
    end
  end

  def edit
    @trigger_form = TriggerForm.new(trigger: trigger)
    @trigger_form.set_default_data
  end

  def update
    @trigger_form = TriggerForm.new(trigger_form_params)
    @trigger_form.trigger = trigger
    @trigger_form.user = trigger.user

    if @trigger_form.valid?
      @trigger_form.save!
      flash[:notice] = 'Trigger updated.'
      redirect_to triggers_path
    else
      render 'edit'
    end
  end

  private

  def trigger_form_params
    params.require(:trigger_form).permit(:repository_name, :branch, :modified_file, :email_address_address, :slack_webhook_url, :message)
  end

end
