module GroupsHelper

  def user_points_for_week(user, week)
    total = 0
    current_week = (week..week.end_of_week)
    user.assignments.select { |a| current_week.include?(a.date) }.each do |assignment|
      total += assignment.chore.difficulty
    end
    return total
  end

end
