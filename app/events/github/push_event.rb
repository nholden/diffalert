module Github
  class PushEvent < Struct.new(:payload_hash)

    def modified_files
      commits.map { |commit| commit[:modified] }.flatten.compact.uniq
    end

    def branch
      payload_hash[:ref].split('/').last
    end

    def repository_name
      payload_hash.dig(:repository, :name)
    end

    private

    def commits
      payload_hash[:commits] || []
    end

  end
end
