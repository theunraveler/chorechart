class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates_uniqueness_of :user_id, :scope => :group_id, :message => 'is already part of this group'
  validates_presence_of :user_id, :group_id

  delegate :email, :name, :username, :to => :user
end
