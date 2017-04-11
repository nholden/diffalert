require 'rails_helper'

RSpec.describe "Github event responses" do

  describe "POST /users/:user_id/github" do
    Given(:user) { FactoryGirl.create(:user) }
    Given(:response_hash) { JSON.load(response.body) }
    Given(:modified_file) { "README.md" }
    Given(:branch) { "master" }
    Given(:request_params) { { ref: "refs/head/#{branch}", commits: [ { modified: [modified_file] } ] } }

    When { post "/users/#{user.id}/github", params: request_params }

    context "when Github secret belongs to a User" do
      Given { allow_any_instance_of(GithubEventResponsesController).to receive(:valid_signature?).and_return(true) }

      Invariant { response_hash == { 'message' => 'Success' } }
      Invariant { response.status == 200 }

      context "when trigger exists for modified file and branch" do
        Given!(:trigger) { FactoryGirl.create(:trigger, user: user, modified_file: modified_file, branch: branch) }

        Then { user.alerts.last.trigger == trigger }
      end

      context "when trigger exists for modified file on different branch" do
        Given!(:trigger) { FactoryGirl.create(:trigger, user: user, modified_file: modified_file, branch: "not-master") }

        Then { user.alerts.empty? }
      end

      context "when no trigger exists for modified file" do
        Then { user.alerts.empty? }
      end
    end

    context "when Github secret does not belong to a User" do
      Given { allow_any_instance_of(GithubEventResponsesController).to receive(:valid_signature?).and_return(false) }

      Then { response_hash == { 'message' => 'Invalid secret' } }
      And { response.status == 401 }
    end
  end

end
