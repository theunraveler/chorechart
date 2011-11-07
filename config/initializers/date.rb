class Date
  def in_current_week?
    self.beginning_of_week == Time.current.to_date.beginning_of_week
  end
end
