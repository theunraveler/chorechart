class Assigner < ActiveRecord::Observer
  observe :chore, :group

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
