require 'rails_helper'

RSpec.describe "Github events API" do

  context "POST /github" do
    Given(:response_hash) { JSON.load(response.body) }
    When { post '/github', headers: { 'X-Hub-Signature' => 'test' } }
    Then { response_hash == { 'status' => 'Success' } }
  end

end
