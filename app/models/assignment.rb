class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :chore
  has_one :group, :through => :chore

  delegate :difficulty, :to => :chore
end
