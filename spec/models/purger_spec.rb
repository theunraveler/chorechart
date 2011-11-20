require 'spec_helper'

describe Purger do
  before(:all) do
    ActiveRecord::Observer.enable_observers
    @obs = Purger.instance
  end

  describe "callbacks" do
    it "should get called when a chore is added" do
      @obs.should_receive(:after_save)
      chore = FactoryGirl.create(:chore)
    end

    it "should get called when a chore is deleted" do
      @obs.should_receive(:after_destroy)
      chore = FactoryGirl.create(:chore)
      chore.destroy
    end

    it "should get called when a chore is edited" do
      @obs.should_receive(:after_save).twice
      chore = FactoryGirl.create(:chore)
      chore.difficulty = 4
      chore.save
    end

    it "should get called when a membership is added" do
      @obs.should_receive(:after_save)
      FactoryGirl.create(:membership)
    end

    it "should get called when a membership is deleted" do
      @obs.should_receive(:after_destroy)
      membership = FactoryGirl.create(:membership)
      membership.destroy
    end

    it 'should delete all assignments for the group' do
      chore = FactoryGirl.build(:chore)
      chore.should_receive(:delete_assignments)
      @obs.after_save(chore)
    end
  end

  after :all do
    ActiveRecord::Observer.disable_observers
  end  
end
