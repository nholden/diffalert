require 'rails_helper'

RSpec.describe Github::PushEvent do

  Given(:push_event) { Github::PushEvent.new(payload_hash) }
  Given(:payload_hash) {
    {
      ref: "refs/heads/another-branch",
      commits: [
        {
          modified: [
            "README.md"
          ],
        },
        {
          modified: [
            "todo.txt"
          ],
        },
      ],
    }
  }

  describe "#modified_files" do
    Then { expect(push_event.modified_files).to match_array(['README.md', 'todo.txt']) }
  end

  describe "#branch" do
    Then { push_event.branch == "another-branch" }
  end

end
