module GroupsHelper

  def user_points_for_week(user, week)
    current_week = (week..week.end_of_week)

    returning [] do |total|
      user.assignments.select { |a| current_week.include?(a.date) }.each do |assignment|
        total << assignment.chore.difficulty
      end
    end.sum
  end

end
