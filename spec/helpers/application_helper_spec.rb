require 'spec_helper'

describe ApplicationHelper do

  describe 'avatar image' do
    before do
      @user = FactoryGirl.build(:user)
    end

    it 'should contain the users hashed email' do
      hashed_email = Digest::MD5.hexdigest(@user.email.strip)
      helper.avatar_image(@user).should =~ /#{hashed_email}/
    end

    it 'should output an image tag' do
      helper.avatar_image(@user).should =~ /<img/
    end

    it 'should request a size if specified' do
      helper.avatar_image(@user, 25).should =~ /\?s=25/
    end
  end

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

  describe 'flash types' do
    { :notice => 'success', :warning => 'warning', :error => 'error' }.each do |orig, rewrite|
      it "should output the corresponding type (#{orig.to_s})" do
        helper.flash_type(orig).should eq(rewrite)
      end
    end
  end

  describe 'active list link' do
    it 'should return true if the page is the current page' do
      helper.stubs(:current_page?).returns(true)
      helper.active_list_link('Test', '/test').should =~ /active/
    end

    it 'should return false otherwise' do
      helper.stubs(:current_page?).returns(false)
      helper.active_list_link('Test', '/test').should_not =~ /active/
    end

    it 'should return a link wrapped in an li' do
      link = helper.active_list_link('Test', '/test')
      link.should =~ /<a href/
      link.should =~ /<li/
    end
  end

end
