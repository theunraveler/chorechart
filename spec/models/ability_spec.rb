require 'spec_helper'
require "cancan/matchers"

describe Ability do
  before do
    @user = FactoryGirl.build(:user)
    @group = FactoryGirl.build(:group)
    @group.stub!(:id).and_return(1)
    @user.stub!(:group_ids).and_return([@group.id])
    @ability = Ability.new(@user)
  end

  context 'as an admin user' do
    before do
      Membership.stub_chain(:find_by_user_id_and_group_id, :is_admin?).and_return(true)
      Membership.any_instance.stub_chain(:group, :id).and_return(1)
      Chore.any_instance.stub_chain(:group, :id).and_return(1)
      Invitation.any_instance.stub_chain(:group, :id).and_return(1)
    end

    describe 'managing groups' do
      [:read, :edit, :destroy, :admin].each do |action|
        it "should allow admins to #{action.to_s} their group" do
          @ability.should be_able_to(action, @group)
        end
      end
    end

    describe 'managing group assets' do
      [:chore, :invitation].each do |klass|
        object = FactoryGirl.build(klass, :group => @group)
        [:create, :edit, :destroy].each do |action|
          it "should allow admins to #{action} #{klass.to_s.pluralize}" do
            @ability.should be_able_to(action, object)
          end
        end
      end

      describe 'deleting memberships' do
        before do
          @membership = FactoryGirl.build(:membership, :group => @group)
          @membership.stub_chain(:group, :id).and_return(1)
        end

        it 'should allow admins to remove membership if > 1' do
          @membership.stub_chain(:group, :memberships, :count).and_return(2)
          @ability.should be_able_to(:destroy, @membership)
        end
      end
    end
  end

  context 'as a non-admin user' do
    before do
      Membership.stub_chain(:find_by_user_id_and_group_id, :is_admin?).and_return(false)
    end

    it 'should allow non-admins to read their group' do
      @ability.should be_able_to(:read, @group)
    end

    [:edit, :delete, :admin].each do |action|
      it "should not allow non-admins to #{action.to_s} their group" do
        @ability.should_not be_able_to(action, @group)
      end
    end
  end

  describe 'creating groups' do
    it 'should allow anyone to create a group' do
      @ability.should be_able_to(:create, Group)
    end
  end
end
