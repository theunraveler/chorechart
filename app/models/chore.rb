class Chore < ActiveRecord::Base
  include ScheduleAttributes

  belongs_to :group
  has_many :assignments

  validates_presence_of :name
  validates_inclusion_of :difficulty, :in => 1..5
end
