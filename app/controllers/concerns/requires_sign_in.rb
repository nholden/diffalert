module RequiresSignIn

  extend ActiveSupport::Concern

  included do
    before_action :require_sign_in!
  end

  private

  def require_sign_in!
    if current_user.nil?
      flash[:warning] = 'You must be logged in to view that page'
      redirect_to new_session_path
    end
  end

end
