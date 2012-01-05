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

  # TODO: Needs some refactoring.
  def create_schedule_for(start, finish)
    points, assignments = {}, []
    users.each { |u| points[u.id] = 0 }

    chore_occurrences_between(start, finish).shuffle.each do |occurrence|
      if points.values.all? { |p| p == 0 }
        lowest_user = users.sample
      else
        lowest_points = points.key(points.values.min)
        lowest_user = users.select { |u| u.id = lowest_points }.first
      end
      points[lowest_user.id] += occurrence[:chore].difficulty
      assignments << Assignment.new(:chore => occurrence[:chore], :user => lowest_user, :date => occurrence[:date])
    end
    Assignment.import assignments
  end

  # Get a list of chores for the day
  def assignments_for(start = Date.current, finish = Date.current)
    assigns = [].concat find_assignments_by_date(start, finish)
    if assigns.empty? && chore_occurrences_between(start, finish).any?
      create_schedule_for(start.beginning_of_week, finish.end_of_week)
      assigns.concat find_assignments_by_date(start, finish, true)
    end
    assigns
  end

  # Same as above, but grouped by date
  def assignments_for_grouped(start = Date.current, finish = Date.current)
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
    assignments.where(:user_id => user.id, :date => current_week).sum(:difficulty)
  end

  # Get chore occurrences within date range
  def chore_occurrences_between(start, finish)
    [].tap do |occurrences|
      chores.each do |chore|
        items = chore.schedule.occurrences_between(start.to_time, finish.advance(:days => 1).to_time)
        occurrences.concat items.collect { |i| { :date => i.to_date, :chore => chore } }
      end
    end
  end

  def clear_schedule
    Assignment.destroy_all :chore_id => chore_ids
  end

  def to_s
    name
  end

  # Memoization
  extend ActiveSupport::Memoizable
  memoize :assignments_for, :assignments_for_grouped, :chore_occurrences_between, :workload

end
