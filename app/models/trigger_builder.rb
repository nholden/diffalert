class TriggerBuilder

  include ActiveModel::Model

  GITHUB_URL_REGEX = /\Ahttps:\/\/github.com\/(?<owner>[\w\-\.]*)\/(?<repository>[\w\-\.]*)\/blob\/(?<branch>[\w\-\.]*)\/(?<file>[\w\-\.\/]*)\Z/

  attr_accessor(:github_url)

  validates :github_url, presence: true, format: { with: GITHUB_URL_REGEX }

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
    github_url.match(GITHUB_URL_REGEX)[:branch]
  end

  def repository
    github_url.match(GITHUB_URL_REGEX)[:repository]
  end

  def file
    github_url.match(GITHUB_URL_REGEX)[:file]
  end

end
