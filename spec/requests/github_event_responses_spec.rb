require 'rails_helper'

RSpec.describe "Github event responses" do

  describe "POST /users/:user_id/github" do
    Given(:user) { FactoryGirl.create(:user) }
    Given(:response_hash) { JSON.load(response.body) }
    Given(:modified_file) { "README.md" }
    Given(:branch) { "master" }
    Given(:repository_name) { "sandbox" }
    Given(:alert) { user.alerts.last }

    Given(:request_params) {
      {
        ref: "refs/head/#{branch}",
        commits: [
          {
            modified: [modified_file]
          }
        ],
        repository: {
          name: repository_name
        },
      }
    }

    When { post "/users/#{user.id}/github", params: request_params }

    context "when Github secret belongs to a User" do
      Given { allow_any_instance_of(GithubEventResponsesController).to receive(:valid_signature?).and_return(true) }

      Invariant { response_hash == { 'message' => 'Success' } }
      Invariant { response.status == 200 }

      context "when trigger exists for modified file, branch, and repo" do
        around(:each) do |example|
          VCR.use_cassette('slack/message/send') { example.run }
        end

        Given!(:trigger) { FactoryGirl.create(:trigger,
                                              user: user,
                                              modified_file: modified_file,
                                              branch: branch,
                                              repository_name: repository_name) }

        context "when the push is a single commit" do
          Then { alert.trigger == trigger }
          And { alert.email == trigger.email_address_address }
          And { alert.slack_webhook_url == trigger.slack_webhook.url }
          And { alert.message == trigger.message }
        end

        context "when the push is a pull request merge" do
          Given { request_params[:head_commit] = { message: 'Merge pull request #42 from nholden/my-feature\n\nMy feature' } }

          context "when the merge commit modifies the file" do
            Given { request_params[:head_commit][:modified] = [modified_file] }

            Then { alert.trigger == trigger }
            And { alert.email == trigger.email_address_address }
            And { alert.slack_webhook_url == trigger.slack_webhook.url }
            And { alert.message == trigger.message }
          end

          context "when the merge commit does not modify the file" do
            Given { request_params[:head_commit][:modified] = [] }

            Then { !alert }
          end
        end
      end

      context "when trigger exists for modified file on different branch" do
        Given!(:trigger) { FactoryGirl.create(:trigger,
                                              user: user,
                                              modified_file: modified_file,
                                              branch: "not-master",
                                              repository_name: repository_name) }

        Then { !alert }
      end

      context "when trigger exists for modified file on different repo" do
        Given!(:trigger) { FactoryGirl.create(:trigger,
                                              user: user,
                                              modified_file: modified_file,
                                              branch: branch,
                                              repository_name: "not-sandbox") }

        Then { !alert }
      end

      context "when no trigger exists for modified file" do
        Then { !alert }
      end
    end

    context "when Github secret does not belong to a User" do
      Given { allow_any_instance_of(GithubEventResponsesController).to receive(:valid_signature?).and_return(false) }

      Then { response_hash == { 'message' => 'Invalid secret' } }
      And { response.status == 401 }
    end
  end

end
