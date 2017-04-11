module Github
  class PushEvent < Struct.new(:payload_hash)

    def modified_files
      commits.map { |commit| commit[:modified] }.flatten.compact.uniq
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

  end
end
