module TriggerFormHelper

  def fill_in_trigger_form
    fill_in 'Branch', with: 'master'
    fill_in 'Email', with: 'qwerty@slack.com'
    fill_in 'Name this email', with: 'Qwerty work'
    fill_in 'Slack webhook URL', with: 'https://hooks.slack.com/services/FOO/BAR/FOOBAR'
    fill_in 'Name this Slack webhook', with: '#general'
    fill_in 'Message', with: 'README.md changed!'
  end

  def fill_in_trigger_builder
    fill_in 'Paste the GitHub link to the file you’d like to monitor',
      with: 'https://github.com/nholden/sandbox/blob/other-branch/README.md'
  end

end

RSpec.configure do |config|
  config.include TriggerFormHelper
end
