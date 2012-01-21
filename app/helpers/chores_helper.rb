module ChoresHelper

  def interval_select(selected = nil)
    options_for_select([['day(s)', 'day'], ['week(s)', 'week'], ['month(s)', 'month']], selected)
  end

end
