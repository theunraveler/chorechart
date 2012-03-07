class Ability
  include CanCan::Ability

  def initialize(user)

    # Start all zipped up
    cannot :manage, :all

    #################
    # GROUPS
    #################
    #
    # Anyone can create a group
    can :create, Group

    # Users can access groups they are part of
    can :read, Group, :id => user.group_ids
    can [:update, :destroy, :invite, :admin], Group do |group|
      is_admin_in_group? user.id, group.id
    end

    ###################
    # MEMBERSHIPS
    ###################

    # Only admins can manage Memberships
    can :manage, [Membership, Chore, Invitation] do |object|
      is_admin_in_group? user.id, object.group.id
    end

    # Only admins can remove users from groups, and only if group members > 1
    can :destroy, Membership do |membership|
      membership.group.memberships.count > 1 && is_admin_in_group?(user.id, membership.group_id)
    end

    ####################
    # USERS
    ####################

    # Users can update and delete their own profiles
    can :manage, User, :id => user.id
    can :manage, Authentication, :id => user.authentication_ids

  end

  def is_admin_in_group?(user_id, group_id)
    Membership.find_by_user_id_and_group_id(user_id, group_id).is_admin?
  end
end
