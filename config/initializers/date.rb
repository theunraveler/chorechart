class Date
  def in_current_week?
    self.beginning_of_week == Date.today.beginning_of_week
  end
end
