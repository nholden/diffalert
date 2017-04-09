class AlertProcessor

  def initialize(alert)
    @alert = alert
  end

  def process
    AlertMailer.modified_file_email(@alert).deliver
  end

end
