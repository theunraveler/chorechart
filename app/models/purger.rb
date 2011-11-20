class Purger < ActiveRecord::Observer
  observe :chore, :membership

  def after_save(object)
    object.delete_assignments
  end

  def after_destroy(object)
    object.delete_assignments
  end
end
