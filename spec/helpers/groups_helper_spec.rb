require 'spec_helper'

describe GroupsHelper do
  describe 'user points for week' do
    before do
      create_mocks
    end

    it 'should return the appropriate workload' do
      bobs = helper.user_points_for_week(@users['bob'], Date.today.beginning_of_week)
      franks = helper.user_points_for_week(@users['frank'], Date.today.beginning_of_week)
      difference = (bobs - franks).abs
      difference.should be < 10
    end

    def create_mocks
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
  end
end
