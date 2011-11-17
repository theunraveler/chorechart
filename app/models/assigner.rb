class Assigner < ActiveRecord::Observer
  observe :chore, :membership

  def after_create(object)
    self.class.destroy_assignments_for_group(object.group)
  end

  def after_update(object)
    self.class.destroy_assignments_for_group(object.group)
  end

  def after_destroy(object)
    self.class.destroy_assignments_for_group(object.group)
  end

  def self.destroy_assignments_for_group(group)
    Assignment.delete_all(:chore_id => group.chores.collect(&:id))
  end

  # Needs some refactoring.
  def self.create_schedule_for(group, start, finish)
    users = group.users
    points = {}
    users.each { |u| points[u.id] = 0 }
    chores = group.chores
    occurrences = []

    chores.each do |chore|
      chore.schedule.occurrences_between(start.to_time, finish.advance(:days => 1).to_time).each do |occurrence|
        occurrences << {
          :date => occurrence.to_date,
          :chore => chore
        }
      end
    end

    assignments = []
    occurrences.shuffle.each do |occurrence|
      if points.values.all? { |p| p == 0 }
        lowest_user = users.sample
      else
        lowest_points = points.key(points.values.min)
        lowest_user = users.select { |u| u.id = lowest_points }.first
      end
      points[lowest_user.id] += occurrence[:chore].difficulty
      assignments << Assignment.new(:chore => occurrence[:chore], :user => lowest_user, :date => occurrence[:date])
    end
    Assignment.import assignments
  end
end
