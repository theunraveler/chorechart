class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :chores

  validates_presence_of :name

  # Add a user to the group
  def add_user(user, role = "")
    role = "is_#{role}".to_sym
    Membership.new(:user_id => user.id, :group_id => id, role => true ).save
  end
end
