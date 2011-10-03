class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new.readonly!

    can :create, Group
    can :read, Group, :id => user.group_ids 
    can :update, Group do |group|
      membership = Membership.find_by_user_id_and_group_id(user.id, group.id)
      membership.is_admin?
    end
    can :destroy, Group do |group|
      membership = Membership.find_by_user_id_and_group_id(user.id, group.id)
      membership.is_admin?
    end
    can :invite, Group do |group|
      membership = Membership.find_by_user_id_and_group_id(user.id, group.id)
      membership.is_admin?
    end

    can :destroy, Membership do |membership|
      user_membership = Membership.find_by_user_id_and_group_id(user.id, membership.group.id)
      membership.group.memberships.count != 1 && user_membership.is_admin?
    end

    if user.is_admin?
      can :manage, :all 
    end

  end
end
