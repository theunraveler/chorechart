require 'spec_helper'
require 'mocha'

describe Group do
  before(:all) do
    @group = FactoryGirl.build(:group)
  end
  
  describe "#workload" do
    it 'should filter by the specified week'
    it 'should return an integer'
  end

  describe '#to_s' do
    it 'should be the group name' do
      @group.to_s.should eq(@group.name)
    end
  end

  describe '#find_assignments_by_date' do
    it 'should clear the ActiveRecord query cache if specified' do
      ActiveRecord::Base.should_receive(:clear_cache!)
      @group.find_assignments_by_date(Date.today, Date.today, true)
    end

    it 'should not clear the ActiveRecord query cache otherwise' do
      ActiveRecord::Base.should_not_receive(:clear_cache!)
      @group.find_assignments_by_date(Date.today, Date.today)
    end
  end

  describe '#assignments_for_grouped' do
    it 'should basically be a wrapper for assignments_for' do
      @group.stub!(:assignments_for).and_return([])
      @group.should_receive(:assignments_for)
      @group.assignments_for_grouped
    end
  end

  describe '#chore_occurrences_between' do
    before do
      Chore.stub_chain(:schedule, :occurrences_between).and_return([
        Time.parse('25/01/2010'), 
        Time.parse('26/01/2010'),
        Time.parse('29/01/2010')
      ])
      5.times { @group.chores.build }
    end

    it 'should return an array of occurrences' do
      occurrences = @group.chore_occurrences_between(Time.parse('24/01/2010').to_date, Time.parse('30/01/2010').to_date)
      occurrences.should be_an(Array)
      # occurrences.count.should eq(3)
    end

    it 'should not return occurrences outside of the specified range'
  end

  describe '#clear_schedule' do
    it 'should delete assignments for each chore' do
      @group.stub(:chore_ids).and_return([1, 2, 3])
      Assignment.should_receive(:destroy_all).with({:chore_id => [1, 2, 3]}).once
      @group.clear_schedule
    end
  end
end
