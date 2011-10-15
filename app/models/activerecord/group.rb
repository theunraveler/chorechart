class Group < ActiveRecord::Base

  # Associations
  with_options :dependent => :destroy do |a|
    a.has_many :memberships
    a.has_many :chores
    a.has_many :assignments, :through => :chores
  end
  has_many :users, :through => :memberships

  validates_presence_of :name

  # Add a user to the group
  def add_user(user, role = "")
    role = "is_#{role}".to_sym
    memberships.create({ :user_id => user.id, :group_id => id, role => true })
  end

  # Get a list of chores for the day
  def assignments_for(start = Date.today, finish = Date.today, includes = [])
    assigns = assignments.find_all_by_date(start..finish, :include => includes)
    if assigns.empty? && should_have_assignments?(start, finish)
      Assigner.create_schedule_for(self, start, finish)
      # Reload data from the DB so we don't get stale data
      reload
      assigns = assignments_for(start, finish)
    end
    return assigns
  end

  # Determine if a group should have assignments for a given week.
  def should_have_assignments?(start, finish)
    chores.each do |chore|
      if !chore.schedule.occurrences_between(start.to_time, finish.advance(:days => 1).to_time).empty?
        return true
      end
    end
    return false
  end

  def to_pdf(week, week_chores)
    header = users.collect(&:to_s).unshift('')
    data = []

    (week..week.end_of_week).each do |date|
      row = []
      row << date.strftime('%A, %B %d')

      users.each do |user|
        string = String.new
        week_chores.select { |a| a.user == user && a.date == date }.each do |assignment|
          string << "#{assignment.chore}\n\n"
        end
        row << string
      end
      data << row
    end

    Prawn::Document.new(:page_layout => :landscape) do |pdf|
      pdf.pad(20) do
        pdf.text("#{self} for the week of #{week.strftime('%B %d')}", :align => :center, :size => 24)
      end

      pdf.table(data.unshift(header), :header => true, :width => pdf.bounds.width) do
        row(0).style(:font_style => :bold, :background_color => 'cccccc')
      end
    end.render
  end

  def to_s
    name
  end

end
