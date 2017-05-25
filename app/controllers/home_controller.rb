class HomeController < ApplicationController

  def show
    redirect_to triggers_path if current_user
  end

end
