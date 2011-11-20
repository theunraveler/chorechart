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
    assigns = [].concat find_assignments_by_date(start, finish)
    if assigns.empty? && chore_occurrences_between(start, finish).any?
      Assigner.create_schedule_for(self, start.beginning_of_week, finish.end_of_week)
      assigns.concat find_assignments_by_date(start, finish, true)
    end
    assigns
  end

  # Same as above, but grouped by date
  def assignments_for_grouped(start = Time.current.to_date, finish = Time.current.to_date)
    assignments = assignments_for(start, finish).group_by(&:date)
    ((start..finish).to_a - assignments.keys).each { |date| assignments.update({date => []}) }
    Hash[assignments.sort]
  end

  def find_assignments_by_date(start, finish, clear = false)
    ActiveRecord::Base.clear_cache! if clear
    assignments.find_all_by_date(start..finish)
  end

  # Get a user's workload for a certain week
  def workload(user, week)
    current_week = week.beginning_of_week..week.end_of_week
    assignments.where(:user_id => user.id, :date => current_week).sum(:difficulty).to_i
  end

  # Get chore occurrences within date range
  def chore_occurrences_between(start, finish)
    start, finish = start.to_time, finish.advance(:days => 1).to_time
    [].tap do |occurrences|
      chores.each do |chore|
        items = chore.schedule.occurrences_between(start, finish)
        occurrences.concat items.collect { |i| { :date => i.to_date, :chore => chore } }
      end
    end
  end

  def delete_assignments
    assignments.delete_all
  end

  def to_s
    name
  end

end
