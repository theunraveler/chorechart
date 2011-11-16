class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :chore
  has_one :group, :through => :chore
end
