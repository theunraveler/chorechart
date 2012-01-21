require 'spec_helper'

describe PurgesGroupSchedule do
  before do
    @object = TestPurger.new
    @object.stub(:group).and_return(FactoryGirl.build(:group))
  end

  describe 'callbacks' do
    it 'should call #clear_assignments when the object is saved with included attributes' do
      @object.stub(:changed_attributes).and_return({ :test => '' })
      @object.should_receive(:clear_schedule).once
      @object.run_callbacks(:save)
    end

    it 'should only fire an included attribute has been changed' do
      @object.stub(:changed_attributes).and_return({ :no_test => '' })
      @object.should_not_receive(:clear_schedule)
      @object.run_callbacks(:save)
    end

    it 'should call #clear_assignments when the object is deleted' do
      @object.should_receive(:clear_schedule).once
      @object.run_callbacks(:destroy)
    end
  end

  describe '.clear_schedule_on_change' do
    it 'should be a method on the class' do
      TestPurger.should respond_to(:clear_schedule_on_change)
    end

    it 'should assign a class variable for declared attributes' do
      TestPurger.instance_variable_get(:@clear_on_attributes).should eq([:test, :testing])
    end
  end

  describe '.schedule_clearing_attributes' do
    it 'should return an array of attributes' do
      TestPurger.schedule_clearing_attributes.should eq([:test, :testing])
    end
  end
end

class TestPurger
  include ActiveRecord::Callbacks
  include ActiveModel::Dirty
  include PurgesGroupSchedule

  clear_schedule_on_change :test, :testing
end

