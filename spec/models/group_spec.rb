require 'spec_helper'
require 'mocha'

describe Group do
  before(:all) do
    @group = FactoryGirl.build(:group)
  end
  
  describe "workload" do
  end

  describe 'to string' do
    it 'should be the group name' do
      @group.to_s.should eq(@group.name)
    end
  end

  describe 'find assignments by date' do
    it 'should clear the ActiveRecord query cache if specified' do
      ActiveRecord::Base.should_receive(:clear_cache!)
      @group.find_assignments_by_date(Date.today, Date.today, true)
    end

    it 'should not clear the ActiveRecord query cache otherwise' do
      ActiveRecord::Base.should_not_receive(:clear_cache!)
      @group.find_assignments_by_date(Date.today, Date.today)
    end
  end

  describe 'assignments_for_grouped' do
    it 'should basically be a wrapper for assignments_for' do
      @group.should_receive(:assignments_for)
      @group.assignments_for_grouped
    end
    
  end

end
