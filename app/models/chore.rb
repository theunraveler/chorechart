class Chore < ActiveRecord::Base
  include ScheduleAttributes

  belongs_to :group
end
