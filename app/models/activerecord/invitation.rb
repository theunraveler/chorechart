class Invitation < ActiveRecord::Base
  belongs_to :group

  def to_s
    email
  end
end
