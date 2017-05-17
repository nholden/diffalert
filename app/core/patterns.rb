class Patterns

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_SLACK_WEBHOOK_URL_REGEX = /\Ahttps:\/\/hooks\.slack\.com\/.+\z/i
  VALID_GITHUB_FILE_URL_REGEX = /\Ahttps:\/\/github.com\/(?<owner>[\w\-\.]*)\/(?<repository>[\w\-\.]*)\/blob\/(?<branch>[\w\-\.]*)\/(?<file>[\w\-\.\/]*)\Z/

end
