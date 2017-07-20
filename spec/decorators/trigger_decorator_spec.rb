require 'rails_helper'

RSpec.describe TriggerDecorator do

  Given(:trigger) { Trigger.new }
  Given(:decorator) { trigger.decorate }

  describe "#modified_file_name" do
    When(:result) { decorator.modified_file_name }

    context "when modified_file is in the repository's root directory" do
      Given { trigger.modified_file = 'README.md' }
      Then { result == 'README.md' }
    end

    context "when modified_file is in a repository subdirectory" do
      Given { trigger.modified_file = 'spec/decorators/trigger_decorator_spec.rb' }
      Then { result == 'trigger_decorator_spec.rb' }
    end

    context "when modified_file is nil" do
      Given { trigger.modified_file = nil }
      Then { result == 'All files' }
    end
  end

end
