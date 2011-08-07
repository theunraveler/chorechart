class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new.readonly!

    can :create, Group
    can :read, Group, :id => user.group_ids 
    can :invite, Group do |group|
      membership = Membership.find_by_user_id_and_group_id(user.id, group.id)
      membership.is_admin?
    end

  end
end
