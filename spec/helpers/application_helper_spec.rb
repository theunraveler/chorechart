require 'spec_helper'

describe ApplicationHelper do

  describe "format date" do
    before do
      @date = Date.civil(2001, 8, 11)
    end

    it "should default to the short format" do
      helper.format_date(@date).should eql('08/11/01')
    end

    it "should output a medium format" do
      helper.format_date(@date, :style => :medium).should eql('Saturday, August 11')
    end
  end

  describe 'fuzzy date' do
    before do
      Timecop.freeze(2001, 8, 11)
    end

    it "should show 'Today'" do
      helper.fuzzy_date(Time.now).should eq('Today')
    end

    it "should show 'Tomorrow'" do
      helper.fuzzy_date(Time.now.tomorrow).should eq('Tomorrow')
    end

    it "should show weekday for days < 7 days ago" do
      helper.fuzzy_date(Time.now.advance(:days => 2)).should eq('Monday')
      helper.fuzzy_date(Time.now.advance(:days => 6)).should eq('Friday')
    end

    it "should show 'in x days' for days 7 < x < 14" do
      helper.fuzzy_date(Time.now.advance(:days => 8)).should eq('In 8 days')
      helper.fuzzy_date(Time.now.advance(:days => 13)).should eq('In 13 days')
    end

    it "should show format_date for everything else" do
      helper.fuzzy_date(Time.now.advance(:days => 14)).should eq('08/25/01')
      helper.fuzzy_date(Time.now.advance(:days => 30)).should eq('09/10/01')
      helper.fuzzy_date(Time.now.advance(:days => 255)).should eq('04/23/02')
    end

    after do
      Timecop.return
    end
  end

  describe 'in current week' do
    it 'should return true if given a date in the current week' do
      helper.in_current_week?(Date.today).should be_true
    end

    it 'should return false otherwise' do
      helper.in_current_week?(Date.today.advance(:days => 10)).should be_false
    end
  end

end
