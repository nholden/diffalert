require 'rails_helper'

RSpec.describe "Github events API" do

  context "POST /user/:user_id/github" do
    Given!(:user) { FactoryGirl.create(:user, github_events_secret: user_secret) }
    Given(:response_hash) { JSON.load(response.body) }
    Given(:modified_file) { "README.md" }
    Given(:request_secret) { 'abc123' }
    Given(:request_params) { { commits: { modified: [modified_file] } } }

    When { post "/user/#{user.id}/github",
           params: request_params,
           headers: { 'X-Hub-Signature' => 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), request_secret, CGI.unescape(request_params.to_param)) } }

    context "when Github secret belongs to a User" do
      Given(:user_secret) { request_secret }

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
      Given(:user_secret) { 'invalid' }

      Then { response_hash == { 'message' => 'Invalid secret' } }
      And { response.status == 401 }
    end
  end

end
