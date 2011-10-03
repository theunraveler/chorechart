class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :chores, :dependent => :destroy
  has_many :assignments, :through => :chores, :dependent => :destroy

  validates_presence_of :name

  # Add a user to the group
  def add_user(user, role = "")
    role = "is_#{role}".to_sym
    memberships.create({ :user_id => user.id, :group_id => id, role => true })
  end

  # Get a list of chores for the week
  def assignments_for_week(date = Date.today)
    assigns = assignments.find_all_by_date(date.beginning_of_week..date.end_of_week)
    if assigns.empty? && should_have_assignments?(date)
      Assigner.create_schedule_for_week(self, date)
      # Reload data from the DB so we don't get stale data
      reload
      assigns = assignments_for_week(date)
    end
    return assigns
  end

  # Determine if a group should have assignments for a given week.
  def should_have_assignments?(date)
    chores.each do |chore|
      if !chore.schedule.occurrences_between(date.beginning_of_week.to_time, date.end_of_week.advance(:days => 1).to_time).empty?
        return true
      end
    end
    return false
  end

end
