require 'rails_helper'

RSpec.describe "Github events API" do

  context "POST /github" do
    Given(:response_hash) { JSON.load(response.body) }
    Given(:secret) { 'abc123' }

    When { post '/github', headers: { 'X-Hub-Signature' => secret } }

    context "when Github secret belongs to a User" do
      Given { FactoryGirl.create(:user, github_events_secret: secret) }

      Then { response_hash == { 'message' => 'Success' } }
      And { response.status == 200 }
    end

    context "when Github secret does not belong to a User" do
      Then { response_hash == { 'message' => 'Cannot find user with that secret' } }
      And { response.status == 401 }
    end
  end

end
