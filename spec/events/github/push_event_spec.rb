require 'rails_helper'

RSpec.describe Github::PushEvent do

  Given(:push_event) { Github::PushEvent.new(payload_hash) }
  Given(:payload_hash) {
    {
      ref: "refs/heads/another-branch",
      commits: [
        {
          modified: [
            "app/models/user.rb",
          ],
        },
        {
          modified: [
            "app/models/order.rb"
          ],
        },
      ],
      repository: {
        name: "sandbox"
      },
    }
  }

  describe "#modified_paths" do
    context "when push is not a pull request merge it looks at all commits" do
      Then { expect(push_event.modified_paths).to match_array(['app', 'app/models', 'app/models/user.rb', 'app/models/order.rb']) }
    end

    context "when push is a pull request merge it only looks at merge commit" do
      Given { payload_hash[:head_commit] = {
        message: 'Merge pull request #42 from nholden/my-feature\n\nMy feature',
        modified: ['README.md'],
      } }

      Then { expect(push_event.modified_paths).to match_array(['README.md']) }
    end
  end

  describe "#branch" do
    Then { push_event.branch == "another-branch" }
  end

  describe "#repository_name" do
    Then { push_event.repository_name == "sandbox" }
  end

end
