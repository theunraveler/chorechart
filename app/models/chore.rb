class Chore < ActiveRecord::Base
  include ScheduleAttributes
  include PurgesGroupSchedule

  belongs_to :group
  has_many :assignments, :dependent => :delete_all

  validates :name, :presence => true, :uniqueness => {:scope => :group_id}
  validates_inclusion_of :difficulty, :in => 1..5

  attr_accessible :name, :group_id, :difficulty, :schedule_attributes

  DIFFICULTY_IN_WORDS = {
    1 => 'Easy',
    2 => 'Meh.',
    3 => 'Kind of hard',
    4 => 'Hard',
    5 => 'Really hard'
  }

  clear_schedule_on_change :difficulty, :schedule_yaml

  # Overridden from ScheduleAttributes
  def schedule_attributes=(options)
    if options[:interval_unit] == 'week'
      # Weekly tasks need a day.
      options[Date.today_as_sym] = '1' if Date::DAYS_INTO_WEEK.keys.none? { |day| options[day] === '1'}
    end

    super(options)
  end

  def difficulty_in_words
    DIFFICULTY_IN_WORDS[self.difficulty]
  end

  def to_s
    name
  end
end
