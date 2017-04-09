module AuthenticationHelper

  def log_in_as(user)
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

end

RSpec.configure do |config|
  config.include AuthenticationHelper
end
