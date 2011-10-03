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

  # Get a list of chores for the day
  def assignments_for(start = Date.today, finish = Date.today)
    assigns = assignments.find_all_by_date(start..finish)
    if assigns.empty? && should_have_assignments?(start, finish)
      Assigner.create_schedule_for(self, start, finish)
      # Reload data from the DB so we don't get stale data
      reload
      assigns = assignments_for(start, finish)
    end
    return assigns
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
