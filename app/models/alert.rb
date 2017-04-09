class Alert < ApplicationRecord

  belongs_to :trigger

  after_create :process

  private

  def process
    AlertProcessor.new(self).process
  end

end
