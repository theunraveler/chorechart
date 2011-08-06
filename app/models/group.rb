class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :chores

  validates_presence_of :name
end
