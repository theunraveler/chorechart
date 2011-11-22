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
      Membership.find_by_user_id_and_group_id(user.id, group.id).is_admin?
    end

    ###################
    # MEMBERSHIPS
    ###################

    # Only admins can manage Memberships
    can :manage, [Membership, Chore, Invitation] do |object|
      Membership.find_by_user_id_and_group_id(user.id, object.group.id).is_admin?
    end

    # Only admins can remove users from groups, and only if group members > 1
    can :destroy, Membership do |membership|
      user_membership = Membership.find_by_user_id_and_group_id(user.id, membership.group.id)
      membership.group.memberships.count != 1 && user_membership.is_admin?
    end

    ####################
    # USERS
    ####################

    # Users can update and delete their own profiles
    can :manage, User, :id => user.id
    can :manage, Authentication, :id => user.authentication_ids

  end
end
