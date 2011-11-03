require 'spec_helper'

describe GroupsHelper do
  describe 'user points for week' do

    it 'should return the appropriate workload' do
      create_mocks_for_two_users
      bobs = helper.user_points_for_week(@users['bob'], Date.today.beginning_of_week)
      franks = helper.user_points_for_week(@users['frank'], Date.today.beginning_of_week)
      difference = (bobs - franks).abs
      difference.should be < 10
    end

    it 'should not be cumulative' do
      create_mocks_for_two_groups

    end


    def create_mocks_for_two_users
      @group = FactoryGirl.create(:group)
      chores = []
      3.times do |i|
        chores << FactoryGirl.create(:chore, :name => "Chore #{i + 1}", :group_id => @group.id, :difficulty => i + 1)
      end
      @users = {}
      ['bob', 'frank'].each do |name|
        @users[name] = FactoryGirl.create(:user, :name => name.capitalize, :email => "#{name}@test.com", :username => name)
        @users[name].memberships.create(:group_id => @group.id).save
      end
      Assigner.create_schedule_for(@group, Date.today.beginning_of_week, Date.today.end_of_week)
    end

    def create_mocks_for_two_groups
      @groups = []
      2.times do |i|
        @groups << FactoryGirl.create(:group, :name => "Group #{i}")
      end
      chores = []
      3.times do |i|
        chores << FactoryGirl.create(:chore, :name => "Chore #{i + 1}", :group_id => @group.id, :difficulty => i + 1)
      end
      @users = {}
      ['bob', 'frank'].each do |name|
        @users[name] = FactoryGirl.create(:user, :name => name.capitalize, :email => "#{name}@test.com", :username => name)
        @users[name].memberships.create(:group_id => @group.id).save
      end
      Assigner.create_schedule_for(@group, Date.today.beginning_of_week, Date.today.end_of_week)
    end
  end
end
