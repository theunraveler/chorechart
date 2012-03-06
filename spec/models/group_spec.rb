require 'spec_helper'

describe Group do
  before(:all) do
    @group = FactoryGirl.build(:group)
  end
  
  describe "#workload" do
    it 'should filter by the specified week' do
      dates = Date.today.beginning_of_week..Date.today.end_of_week
      @group.stub_chain(:assignments, :where).and_return([])
      @group.assignments.should_receive(:where).with(hash_including(:date => dates))
      @group.workload(FactoryGirl.build(:user), Date.today)
    end

    it 'should return an integer' do
      dates = Date.today.beginning_of_week..Date.today.end_of_week
      @group.stub_chain(:assignments, :where, :sum).and_return(5)
      @group.workload(FactoryGirl.build(:user), Date.today).should be_a(Integer)
    end
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

  # TODO: Test this better
  describe '#chore_occurrences_between' do
    before do
      Chore.any_instance.stub_chain(:schedule, :occurrences_between).and_return([
        Time.parse('25/01/2010'), 
        Time.parse('26/01/2010'),
        Time.parse('29/01/2010')
      ])
      @group.chores.build
    end

    it 'should return an array of occurrences' do
      occurrences = @group.chore_occurrences_between(Date.parse('24/01/2010'), Date.parse('30/01/2010'))
      occurrences.should be_an(Array)
      occurrences.count.should eq(3)
    end
  end

  describe '#clear_schedule' do
    it 'should delete assignments for each chore' do
      @group.stub(:chore_ids).and_return([1, 2, 3])
      Assignment.should_receive(:destroy_all).with({:chore_id => [1, 2, 3]}).once
      @group.clear_schedule
    end
  end
end
