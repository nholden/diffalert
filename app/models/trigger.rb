class Trigger < ApplicationRecord

  belongs_to :user
  has_many :alerts

  scope :for_event, -> (event) { where(modified_file: event.modified_files,
                                       branch: event.branch,
                                       repository_name: event.repository_name) }

  validates :modified_file, :message, :branch, :repository_name, presence: true
  validates :email, presence: true, format: { with: Patterns::VALID_EMAIL_REGEX }

end
