require 'spec_helper'

describe Assigner do
  before(:all) do
    ActiveRecord::Observer.enable_observers
    @group = FactoryGirl.create(:group)
    @obs = Assigner.instance
  end

  describe "callbacks" do
    it "should get called when a chore is added" do
      @obs.should_receive(:after_save)
      @group.should_receive(:delete_assignments)
      FactoryGirl.create(:chore, :group_id => @group.id)
    end

    it "should get called when a chore is deleted" do
      @obs.should_receive(:after_destroy)
      chore = FactoryGirl.create(:chore, :group_id => @group.id)
      chore.destroy
    end

    it "should get called when a chore is edited" do
      @obs.should_receive(:after_save).twice
      chore = FactoryGirl.create(:chore, :group_id => @group.id)
      chore.difficulty = 4
      chore.save
    end

    it "should get called when a membership is added" do
      @obs.should_receive(:after_save)
      @group.memberships.create(:user => FactoryGirl.create(:user))
    end

    it "should get called when a membership is deleted" do
      @obs.should_receive(:after_destroy)
      @group.memberships.create(:user => FactoryGirl.create(:user))
      @group.memberships.first.destroy
    end

    it 'should delete all assignments for the group' do
      @group.should_receive(:delete_assignments)
      @obs.after_save(@group.chores.build)
    end
  end

  after :all do
    ActiveRecord::Observer.disable_observers
  end  
end
