require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "new trigger wizard" do

  Given(:user) { FactoryGirl.create(:user) }

  When { log_in_as user }
  When { visit triggers_path }

  describe "creating a new Trigger" do
    When { click_link 'Add trigger' }
    When { fill_in 'Repository', with: 'sandbox' }
    When { fill_in 'Branch', with: 'master' }
    When { fill_in 'File path', with: 'README.md' }
    When { fill_in 'Email', with: 'qwerty@slack.com' }
    When { fill_in 'Message', with: 'README.md changed!' }
    When { click_button 'Save trigger' }

    Then { expect(page).to have_content 'New trigger created!' }
    And { expect(page).to have_content 'sandbox' }
    And { expect(page).to have_content 'master' }
    And { expect(page).to have_content 'README.md' }

    And { user.triggers.last.repository_name == 'sandbox' }
    And { user.triggers.last.branch == 'master' }
    And { user.triggers.last.modified_file == 'README.md' }
    And { user.triggers.last.email == 'qwerty@slack.com' }
    And { user.triggers.last.message == 'README.md changed!' }
  end

end
