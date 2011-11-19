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
    Assignment.delete_all(:chore_id => group.chore_ids)
  end

  # TODO: Needs some refactoring.
  def self.create_schedule_for(group, start, finish)
    users, points, assignments = group.users, {}, []
    users.each { |u| points[u.id] = 0 }
    occurrences = group.chore_occurrences_between(start, finish)

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
