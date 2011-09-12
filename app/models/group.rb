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
  def get_chores_for_week(date = Date.today)
    week = assignments.select { |a| (date.beginning_of_week..date.end_of_week).include?(a.date) }
    week.group_by(&:date)
  end
end
