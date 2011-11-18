require 'spec_helper'
require "cancan/matchers"

describe Ability do

  describe 'groups' do
    context 'admin user' do
      before do
        user = FactoryGirl.create(:user)
        @group = FactoryGirl.create(:group)
        @group.memberships.create(:user_id => user.id, :is_admin => true)
        @ability = Ability.new(user)
      end

      [:read, :edit, :destroy].each do |action|
        it "should allow admins to #{action.to_s} their group" do
          @ability.should be_able_to(action, @group)
        end
      end
    end

    context 'non-admin user' do
      before do
        user = FactoryGirl.create(:user)
        @group = FactoryGirl.create(:group)
        @group.memberships.create(:user_id => user.id, :is_admin => false)
        @ability = Ability.new(user)
      end

      it 'should allow non-admins to read their group' do
        @ability.should be_able_to(:read, @group)
      end

      [:edit, :delete].each do |action|
        it "should not allow non-admins to #{action.to_s} their group" do
          @ability.should_not be_able_to(action, @group)
        end
      end
    end

    context 'creating groups' do
      before do
        user = FactoryGirl.build(:user)
        @ability = Ability.new(user)
      end

      it 'should allow anyone to create a group' do
        @ability.should be_able_to(:create, Group)
      end
    end
  end

end
