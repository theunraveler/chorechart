require 'spec_helper'

describe Chore do
  before(:all) do
    @chore = FactoryGirl.build(:chore)
  end

  describe 'difficulty in words' do
    { 1 => 'Easy',
      2 => 'Meh.',
      3 => 'Kind of hard',
      4 => 'Hard',
      5 => 'Really hard'
    }.each do |diff, words|
      it "should output the proper text (#{diff})" do
        @chore.difficulty = diff
        @chore.difficulty_in_words.should eq(words)
      end
    end
  end

  describe 'schedule attributes assigner' do
    it 'should check to see if a day is set and set one if not' do
      @chore.stub!(:assign_todays_date).and_return({})
      @chore.should_receive(:assign_todays_date)
      @chore.schedule_attributes = { :interval_unit => 'week' }
    end

    it 'should do nothing extra if the interval unit is not week' do
      @chore.stub!(:assign_todays_date).and_return({})
      @chore.should_not_receive(:assign_todays_date)
      @chore.schedule_attributes = { :interval_unit => 'day' }
    end

    it 'should do nothing if a day is set' do
      @chore.stub!(:assign_todays_date).and_return({})
      @chore.should_not_receive(:assign_todays_date)
      @chore.schedule_attributes = { :interval_unit => 'week', :tuesday => '1' }
    end      
  end

  describe 'assign todays date' do
    it 'should return a hash containing todays date' do
      today = Time.current.strftime('%A').downcase.to_sym
      hash = @chore.send(:assign_todays_date)
      hash.count.should eq(1)
      hash.has_key?(today).should be_true
    end
  end

  describe 'to string' do
    it 'should be the chore name' do
      @chore.to_s.should eq(@chore.name)
    end
  end

end
