require 'spec_helper'

describe Group do
  
  describe "workload" do
    before do
      @user = FactoryGirl.create(:user)
      @g1 = FactoryGirl.create(:group, :name => 'Household')
      @g2 = FactoryGirl.create(:group, :name => 'Office')
      @g1.memberships.create(:user_id => @user.id)
      @g2.memberships.create(:user_id => @user.id)

      5.times do |i|
        FactoryGirl.create(:chore, :group_id => @g1.id, :name => "Chore #{i}", :difficulty => 1)
      end
      5.times do |i|
        FactoryGirl.create(:chore, :group_id => @g2.id, :name => "Chore #{i}", :difficulty => 4)
      end
      Assigner.create_schedule_for(@g1, Date.today.beginning_of_week, Date.today.end_of_week)
      Assigner.create_schedule_for(@g2, Date.today.beginning_of_week, Date.today.end_of_week)
    end

    it 'should not give me the same result for each of my groups' do
      workload = @g1.workload(@user, Date.today)
      workload2 = @g2.workload(@user, Date.today)
      workload.should_not eq(workload2)
    end

  end

end
