class Alert < ApplicationRecord

  belongs_to :trigger

  after_create :process

  private

  def process
    AlertWorker.perform_async(id)
  end

end
