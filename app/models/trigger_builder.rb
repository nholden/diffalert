class TriggerBuilder

  include ActiveModel::Model

  attr_accessor(:github_url)

  validates :github_url, presence: true, format: { with: Patterns::VALID_GITHUB_FILE_URL_REGEX }

  def trigger_params
    {
      trigger: {
        branch: branch,
        repository_name: repository,
        modified_file: file,
      },
    }
  end

  private

  def branch
    github_url.match(Patterns::VALID_GITHUB_FILE_URL_REGEX)[:branch]
  end

  def repository
    github_url.match(Patterns::VALID_GITHUB_FILE_URL_REGEX)[:repository]
  end

  def file
    github_url.match(Patterns::VALID_GITHUB_FILE_URL_REGEX)[:file]
  end

end
