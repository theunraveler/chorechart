class Invitation < ActiveRecord::Base
  belongs_to :group

  def to_d
    email
  end
end
