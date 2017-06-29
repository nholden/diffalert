class TriggerBuilder

  include ActiveModel::Model

  attr_accessor(:github_url)

  validates :github_url, presence: true, format: { with: Patterns::GITHUB_FILE_URL_REGEX }

  def trigger_form_params
    {
      trigger_form: {
        branch: branch,
        repository_name: repository,
        modified_file: file,
      },
    }
  end

  private

  def branch
    github_url.match(Patterns::GITHUB_FILE_URL_REGEX)[:branch]
  end

  def repository
    github_url.match(Patterns::GITHUB_FILE_URL_REGEX)[:repository]
  end

  def file
    github_url.match(Patterns::GITHUB_FILE_URL_REGEX)[:file]
  end

end
