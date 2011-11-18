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
  def assignments_for(start = Time.current.to_date, finish = Time.current.to_date)
    assigns = assignments.find_all_by_date(start..finish)
    if assigns.empty? && chore_occurrences_between(start, finish).any?
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
    assignments.select { |a| a.user == user && current_week.include?(a.date) }.collect(&:difficulty).sum
  end

  # Get chore occurrences within date range
  # TODO: Still kind of ugly.
  def chore_occurrences_between(start, finish)
    [].tap do |occurrences|
      chores.each do |chore|
        chore.schedule.occurrences_between(start.to_time, finish.advance(:days => 1).to_time).each do |occurrence|
          occurrences << {
            :date => occurrence.to_date,
            :chore => chore
          }
        end
      end
    end
  end

  def to_s
    name
  end

end
