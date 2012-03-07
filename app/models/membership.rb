class Membership < ActiveRecord::Base
  include PurgesGroupSchedule

  belongs_to :user
  belongs_to :group

  validates_uniqueness_of :user_id, :scope => :group_id, :message => 'is already part of this group'
  validates_presence_of :user_id, :group_id

  attr_accessible :user, :group, :user_id, :group_id, :is_admin

  delegate :email, :name, :username, :to => :user

  clear_schedule_on_change
end
