module Github
  class PushEvent < Struct.new(:payload_hash)

    def modified_paths
      modified_files.map do |modified_file|
        Pathname.new(modified_file).ascend.to_a.map(&:to_s)
      end.flatten.compact.uniq
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

    def modified_files
      if pull_request_merge?
        head_commit[:modified]
      else
        commits.map { |commit| commit[:modified] }.flatten.compact.uniq
      end
    end

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
