require 'rails_helper'

RSpec.describe "User sign up" do

  When { visit new_user_path }
  When { fill_in 'Email', with: 'nick@realhq.com' }
  When { fill_in 'Password', with: 'password' }
  When { fill_in 'Confirm password', with: 'password' }
  When { click_button 'Sign up' }

  Then { expect(page).to have_content 'You’re signed up!' }
  And { User.last.email == 'nick@realhq.com' }

end
