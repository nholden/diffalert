require 'rails_helper'

RSpec.describe Trigger, type: :model do

  describe "validations" do
    Given(:trigger) { FactoryGirl.create(:trigger) }

    describe "modified_file" do
      Given { trigger.modified_file = modified_file }

      context "it is valid with a modified file" do
        When(:modified_file) { 'abc.rb' }
        Then { trigger.valid? }
      end

      context "it is invalid a blank modified file" do
        When(:modified_file) { ' ' }
        Then { !trigger.valid? }
      end
    end

    describe "message" do
      Given { trigger.message = message }

      context "it is valid with a message" do
        When(:message) { 'Important file was updated!' }
        Then { trigger.valid? }
      end

      context "it is invalid with a blank message" do
        When(:message) { ' ' }
        Then { !trigger.valid? }
      end
    end

    describe "email" do
      Given { trigger.email = email }

      context "it is valid with a valid email" do
        When(:email) { 'tony.gwynn@padres.com' }
        Then { trigger.valid? }
      end

      context "it is invalid with an invalid email" do
        When(:email) { 'tony.gwynn@padres' }
        Then { !trigger.valid? }
      end

      context "it is invalid with a blank email" do
        When(:email) { ' ' }
        Then { !trigger.valid? }
      end
    end

    describe "branch" do
      Given { trigger.branch = branch }

      context "it is valid with a branch" do
        When(:branch) { 'master' }
        Then { trigger.valid? }
      end

      context "it is invalid a blank branch" do
        When(:branch) { ' ' }
        Then { !trigger.valid? }
      end
    end

    describe "repository_name" do
      Given { trigger.repository_name = repository_name }

      context "it is valid with a repository name" do
        When(:repository_name) { 'sandbox' }
        Then { trigger.valid? }
      end

      context "it is invalid with a blank repository name" do
        When(:repository_name) { ' ' }
        Then { !trigger.valid? }
      end
    end
  end

end
