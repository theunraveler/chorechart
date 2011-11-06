class Group < ActiveRecord::Base

  # Associations
  with_options :dependent => :destroy do |a|
    a.has_many :memberships
    a.has_many :chores
    a.has_many :assignments, :through => :chores
    a.has_many :invitations
  end
  has_many :users, :through => :memberships

  validates_presence_of :name

  # Get a list of chores for the day
  def assignments_for(start = Date.today, finish = Date.today, includes = [])
    assigns = assignments.find_all_by_date(start..finish, :include => includes)
    if assigns.empty? && should_have_assignments?(start, finish)
      Assigner.create_schedule_for(self, start, finish)
      # Reload data from the DB so we don't get stale data
      reload
      assigns = assignments_for(start, finish)
    end
    return assigns
  end

  # Get a user's workload for a certain week
  def workload(user, week)
    current_week = (week.beginning_of_week..week.end_of_week)

    [].tap do |total|
      assignments.select { |a| a.user == user && current_week.include?(a.date) }.each do |assignment|
        total << assignment.chore.difficulty
      end
    end.sum
  end

  # Determine if a group should have assignments for a given week.
  def should_have_assignments?(start, finish)
    chores.each do |chore|
      if !chore.schedule.occurrences_between(start.to_time, finish.advance(:days => 1).to_time).empty?
        return true
      end
    end
    return false
  end

  def to_s
    name
  end

end
