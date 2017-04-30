require 'rails_helper'

RSpec.describe TriggerBuilder do

  describe "github_url validations" do
    Given(:trigger_builder) { TriggerBuilder.new(github_url: github_url) }

    context "it is valid when github_url is valid" do
      Given(:github_url) { "https://github.com/nholden/sandbox/blob/master/README.md" }
      Then { trigger_builder.valid? }
    end

    context "it is invalid when github_url is blank" do
      Given(:github_url) { " " }
      Then { !trigger_builder.valid? }
    end

    context "it is invalid when github_url is misformed" do
      Given(:github_url) { "https://github.com/nholden/sandbox/master/README.md" }
      Then { !trigger_builder.valid? }
    end
  end

  describe "#trigger_params" do
    Given(:trigger_builder) { TriggerBuilder.new(github_url: github_url) }
    Given(:github_url) { "https://github.com/nholden/sandbox/blob/master/README.md" }

    When(:result) { trigger_builder.trigger_params }

    Then { result[:trigger][:repository_name] == "sandbox" }
    And { result[:trigger][:branch] == "master" }
    And { result[:trigger][:modified_file] == "README.md" }
  end

end
