class Assigner < ActiveRecord::Observer
  observe :chore, :group
end
