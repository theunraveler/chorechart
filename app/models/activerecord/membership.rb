class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates_uniqueness_of :user_id, :scope => :group_id, :message => 'is already part of this group'
  validates_presence_of :user_id, :group_id

  # Get the role of a membership
  def role
    return 'admin' if is_admin?
    return 'editor' if is_editor?
    return 'participant' if is_participant?
  end
end
