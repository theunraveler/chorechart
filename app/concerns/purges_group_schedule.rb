module PurgesGroupSchedule
  def self.included(model)
    model.class_eval do
      delegate :clear_schedule, :to => :group
      model.extend(ClassMethods)

      # Callbacks
      after_create :clear_schedule
      after_save :clear_schedule, :if => :schedule_clearing_attribute_changed?
      after_destroy :clear_schedule
    end
  end

  module ClassMethods
    def clear_schedule_on_change(*attributes)
      @clear_on_attributes = attributes
    end

    def schedule_clearing_attributes
      @clear_on_attributes || []
    end
  end

  private

  def schedule_clearing_attribute_changed?
    self.changed_attributes.keys.any? do |attribute|
      attribute.to_sym.in? self.class.schedule_clearing_attributes
    end
  end
end
