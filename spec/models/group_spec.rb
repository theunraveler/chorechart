require 'spec_helper'
require 'mocha'

describe Group do
  
  describe "workload" do
    before do
      user = FactoryGirl.create(:user)
      g1, g2 = FactoryGirl.create(:group), FactoryGirl.create(:group)
      g1.memberships.create(:user_id => user.id)
      g2.memberships.create(:user_id => user.id)

      5.times do |i|
        FactoryGirl.create(:chore, :group_id => g1.id, :name => "Chore #{i}", :difficulty => 1)
        FactoryGirl.create(:chore, :group_id => g2.id, :name => "Chore #{i}", :difficulty => 4)
      end
      Assigner.create_schedule_for(g1, Date.today.beginning_of_week, Date.today.end_of_week)
      Assigner.create_schedule_for(g2, Date.today.beginning_of_week, Date.today.end_of_week)
      @g1_workload = g1.workload(user, Date.today)
      @g2_workload = g2.workload(user, Date.today)
    end

    it 'should not give me the same result for each of my groups' do
      @g1_workload.should be_a(Integer)
      @g2_workload.should be_a(Integer)
      @g1_workload.should_not eq(@g2_workload)
    end
  end

  describe 'to string' do
    it 'should be the group name' do
      group = FactoryGirl.build(:group)
      group.to_s.should eq(group.name)
    end
  end

  describe 'find assignments by date' do
    before do
      @group = FactoryGirl.build(:group)
    end

    it 'should clear the ActiveRecord query cache if specified' do
      ActiveRecord::Base.should_receive(:clear_cache!)
      @group.find_assignments_by_date(Date.today, Date.today, true)
    end

    it 'should not clear the ActiveRecord query cache otherwise' do
      ActiveRecord::Base.should_not_receive(:clear_cache!)
      @group.find_assignments_by_date(Date.today, Date.today)
    end
  end

end
