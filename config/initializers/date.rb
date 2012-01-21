class Date
  def this_week?
    self.beginning_of_week == ::Date.current.beginning_of_week
  end

  def self.today_as_sym
    ::Date.current.strftime('%A').downcase.to_sym
  end
end
