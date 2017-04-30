class TriggerBuildersController < ApplicationController

  def new
    @trigger_builder = TriggerBuilder.new
  end

  def create
    @trigger_builder = TriggerBuilder.new(trigger_builder_params)

    if @trigger_builder.valid?
      redirect_to new_trigger_path(@trigger_builder.trigger_params)
    else
      render 'new'
    end
  end

  private

  def trigger_builder_params
    params.require(:trigger_builder).permit(:github_url)
  end

end
