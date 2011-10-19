class Chore < ActiveRecord::Base
  include ScheduleAttributes

  belongs_to :group
  has_many :assignments, :dependent => :destroy

  validates_presence_of :name
  validates_inclusion_of :difficulty, :in => 1..5

  before_create :add_default_date

  def to_s
    name
  end

  private

  def add_default_date
    puts self.to_s
  end
end
