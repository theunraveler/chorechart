class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :chores
  has_many :assignments, :through => :chores

  validates_presence_of :name

  # Add a user to the group
  def add_user(user, role = "")
    role = "is_#{role}".to_sym
    Membership.new(:user_id => user.id, :group_id => id, role => true ).save
  end

  # Get a list of chores for the week
  def get_assignments_for_week(date = Date.today)
    if (assigns = _fetch_assignments_for_week(date)).empty? && should_have_assignments?(date)
      Assigner.create_schedule_for_week(self, date)
      assigns = _fetch_assignments_for_week(date)
    end
    return assigns
  end

  # Determine if a group should have assignments for a given week.
  def should_have_assignments?(date)
    chores.each do |chore|
      puts chore.schedule.occurrences_between(date.beginning_of_week.to_time, date.end_of_week.advance(:days => 1).to_time).to_s
      if !chore.schedule.occurrences_between(date.beginning_of_week.to_time, date.end_of_week.advance(:days => 1).to_time).empty?
        return true
      end
    end
    return false
  end

  private

  # TODO: Refactor; this doesn't scale.
  def _fetch_assignments_for_week(date)
    assignments.select { |a| (date.beginning_of_week..date.end_of_week).include?(a.date) }
  end
end
