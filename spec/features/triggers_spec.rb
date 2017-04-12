require 'rails_helper'
require 'support/authentication_helper'

RSpec.describe "triggers" do

  describe "creating a new trigger" do
    Given(:user) { FactoryGirl.create(:user) }

    When { log_in_as user }
    When { click_link 'Add trigger' }
    When { fill_in 'Repository', with: 'sandbox' }
    When { fill_in 'Branch', with: 'master' }
    When { fill_in 'Filename', with: 'README.md' }
    When { fill_in 'Email', with: 'qwerty@slack.com' }
    When { fill_in 'Message', with: 'README.md changed!' }
    When { click_button 'Create trigger' }

    Then { expect(page).to have_content 'New trigger created!' }
    And { expect(page).to have_content 'When README.md changes, send an email to qwerty@slack.com saying “README.md changed!”' }
    And { user.triggers.last.modified_file == 'README.md' }
    And { user.triggers.last.email == 'qwerty@slack.com' }
    And { user.triggers.last.message == 'README.md changed!' }
  end

  describe "deleting a trigger" do
    Given(:user) { FactoryGirl.create(:user) }
    Given!(:trigger) { FactoryGirl.create(:trigger, user: user) }

    When { log_in_as user }
    When { click_link 'Delete' }

    Then { expect(page).to have_content 'Trigger deleted.' }
    And { expect(page).to_not have_content(trigger.modified_file) }
    And { !Trigger.find_by_id(trigger.id) }
  end

end
