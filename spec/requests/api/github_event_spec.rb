require 'rails_helper'

RSpec.describe "Github events API" do

  context "POST /github" do
    Given(:response_hash) { JSON.load(response.body) }
    Given(:secret) { 'abc123' }
    Given(:modified_file) { "README.md" }

    When { post '/github',
           params: { commits: { modified: [modified_file] } },
           headers: { 'X-Hub-Signature' => secret } }

    context "when Github secret belongs to a User" do
      Given!(:user) { FactoryGirl.create(:user, github_events_secret: secret) }

      Invariant { response_hash == { 'message' => 'Success' } }
      Invariant { response.status == 200 }

      context "when trigger exists for modified file" do
        Given!(:trigger) { FactoryGirl.create(:trigger, user: user, modified_file: modified_file) }

        Then { user.alerts.last.trigger == trigger }
      end

      context "when no trigger exists for modified file" do
        Then { user.alerts.empty? }
      end
    end

    context "when Github secret does not belong to a User" do
      Then { response_hash == { 'message' => 'Cannot find user with that secret' } }
      And { response.status == 401 }
    end
  end

end
