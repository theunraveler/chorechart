require 'spec_helper'

describe Assigner do
  
  describe "callbacks" do
    before do
      user = FactoryGirl.create(:user)
      @group = FactoryGirl.create(:group)
      @group.memberships.create(:user_id => user.id)
      5.times do |i|
        FactoryGirl.create(:chore, :group_id => @group.id)
      end
      Assigner.create_schedule_for(@group, Date.today.beginning_of_week, Date.today.end_of_week)
    end

    it "should delete all assignments when a chore is added" do
      @group.assignments.count.should_not eq(0)
      FactoryGirl.create(:chore, :group_id => @group)
      @group.assignments.count.should eq(0)
    end

    it "should delete all assignments when a chore is deleted" do
      @group.assignments.count.should_not eq(0)
      @group.chores.first.destroy
      @group.assignments.count.should eq(0)
    end

    it "should delete all assignments when a chore is edited" do
      @group.assignments.count.should_not eq(0)
      chore = @group.chores.first
      chore.difficulty = 4
      chore.save
      @group.assignments.count.should eq(0)
    end

    it "should delete all assignments when a membership is added" do
      @group.assignments.count.should_not eq(0)
      new_user = FactoryGirl.create(:user)
      @group.memberships.create(:user_id => new_user.id)
      @group.assignments.count.should eq(0)
    end

    it "should delete all assignments when a membership is deleted" do
      new_user = FactoryGirl.create(:user)
      @group.memberships.create(:user_id => new_user.id)
      Assigner.create_schedule_for(@group, Date.today.beginning_of_week, Date.today.end_of_week)
      @group.assignments.count.should_not eq(0)
      @group.memberships.first.destroy
      @group.assignments.count.should eq(0)
    end

  end

end
