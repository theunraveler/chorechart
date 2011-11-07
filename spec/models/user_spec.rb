require 'spec_helper'

describe User do
  
  before do
    @user = FactoryGirl.create(:user, :name => 'Benjamin Franklin')
  end

  describe "first name" do
    it "should display the user's first name if one exists" do
      @user.first_name.should eq('Benjamin')
    end

    it "should return nil if the user has no name" do
      @user.name = ''
      @user.first_name.should be_nil
    end
  end

  describe "last name" do
    it "should display the user's last name if one exists" do
      @user.last_name.should eq('Franklin')
    end

    it "should return nil if the user has no name" do
      @user.name = ''
      @user.last_name.should be_nil
    end
  end

  describe 'apply omniauth' do
    ['github', 'facebook'].each do |provider|
      it "should assign the proper user attributes if they exist (#{provider})" do
        auth_hash = {
          'provider' => provider,
          'info' => { 'nickname' => Faker::Internet.user_name, 'name' => Faker::Name.name, 'email' => Faker::Internet.email }
        }
        @user.apply_omniauth(auth_hash, true)
        @user.name.should eq(auth_hash['info']['name'])
        @user.username.should eq(auth_hash['info']['nickname'])
        @user.email.should eq(auth_hash['info']['email'])
      end
    end

    it 'should assign the proper user attributes if they exist (twitter)' do
      auth_hash = {
        'provider' => 'twitter',
        'info' => { 'nickname' => Faker::Internet.user_name, 'name' => Faker::Name.name }
      }
      @user.apply_omniauth(auth_hash, true)
      @user.name.should eq(auth_hash['info']['name'])
      @user.username.should eq(auth_hash['info']['nickname'])
    end
  end

  describe 'to string' do
    it "should return the user's first name if they have one" do
      @user.to_s.should eq(@user.first_name)
    end

    it 'should return the username otherwise' do
      @user.name = nil
      @user.to_s.should eq(@user.username)
    end
  end

  describe 'time zone handling' do
    it 'should allow me to set my time zone' do
      Time.zone.to_s.should eq('(GMT-06:00) Central Time (US & Canada)')
      @user.time_zone = 'Pacific Time (US & Canada)'
      Time.zone.should eq('Pacific Time (US & Canada)')
    end
  end

end
