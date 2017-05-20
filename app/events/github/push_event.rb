module Github
  class PushEvent < Struct.new(:payload_hash)

    def modified_files
      if pull_request_merge?
        head_commit[:modified]
      else
        commits.map { |commit| commit[:modified] }.flatten.compact.uniq
      end
    end

    def branch
      if ref = payload_hash[:ref]
        ref.split('/').last
      end
    end

    def repository_name
      payload_hash.dig(:repository, :name)
    end

    private

    def commits
      payload_hash[:commits] || []
    end

    def head_commit
      payload_hash[:head_commit] || {}
    end

    def pull_request_merge?
      head_commit[:message] =~ /Merge pull request/
    end

  end
end
