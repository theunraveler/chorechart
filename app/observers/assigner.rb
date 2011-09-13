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
    Assignment.destroy_all(:chore => group.chores)
  end

  def self.create_schedule_for_week(group, week)
    users = group.users
    chores = group.chores
    occurrences = []

    chores.each do |chore|
      chore.schedule.occurrences_between(week.to_time, week.end_of_week.advance(:days => 1).to_time).each do |occurrence|
        occurrences << {
          :date => occurrence.to_date,
          :chore => chore
        }
      end
    end

    occurrences.each do |occurrence|
      Assignment.create(:chore => occurrence[:chore], :user => users.sample, :date => occurrence[:date])
    end
  end
end
