class Invitation < ActiveRecord::Base
  # Associations
  belongs_to :group

  attr_accessible :group_id, :email

  # Validations
  validates :email, :presence => true,
                    :email => true,
                    :uniqueness => { :scope => :group_id, :message => 'already has a pending invitation for this group' }

  def to_s
    email
  end
end
