class Chore < ActiveRecord::Base
  include ScheduleAttributes

  belongs_to :group
  has_many :assignments, :dependent => :delete_all

  validates :name, :presence => true, :uniqueness => {:scope => :group_id}
  validates_inclusion_of :difficulty, :in => 1..5

  delegate :delete_assignments, :to => :group

  DIFFICULTY_IN_WORDS = {
    1 => 'Easy',
    2 => 'Meh.',
    3 => 'Kind of hard',
    4 => 'Hard',
    5 => 'Really hard'
  }

  # Overridden from ScheduleAttributes
  def schedule_attributes=(options)
    if options[:interval_unit] == 'week'
      # Weekly tasks need a day.
      has_day = false
      Date::DAYNAMES.map { |d| d.downcase.to_sym }.each do |day|
        if options[day] === '1'
          has_day = true
        end
      end
      if !has_day
        today = Time.current.strftime('%A').downcase.to_sym
        options[today] = '1'
      end
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
