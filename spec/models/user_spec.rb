require 'spec_helper'

describe User do
  
  before do
    @user = FactoryGirl.build(:user, :name => 'Benjamin Franklin')
  end

  describe 'update with password' do
    it 'should call update_without_password on itself' do
      @user.should_receive(:update_without_password)
      @user.update_with_password
    end

    it 'should remove the current_password parameter' do
      params = { :current_password => 'Hello', :test_param => 'Test Param' }
      @user.should_receive(:update_without_password).with(hash_not_including(:current_password => 'Hello'))
      @user.update_with_password(params)
    end
  end

  describe 'first name' do
    it "should display the user's first name if one exists" do
      @user.first_name.should eq('Benjamin')
    end

    it "should return nil if the user has no name" do
      @user.name = ''
      @user.first_name.should be_nil
    end
  end

  describe 'assignments for' do
    it 'should call assignments_for for each group'
  end

  describe 'apply omniauth' do
    ['github', 'facebook', 'google_oauth2'].each do |provider|
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

  describe 'generate password' do
    it 'should generate a six-character password' do
      @user.generate_password
      @user.password.length.should eq(6)
    end

    it 'should set the password and password confirmation attributes' do
      @user.generate_password
      @user.password.should eq(@user.password_confirmation)
    end
  end

  describe 'find for database authentication' do
    it 'should return the proper record for username' do
      @user.username = Faker::Internet.user_name
      @user.save
      db_user = User.find_for_database_authentication(:login => @user.username)
      db_user.should eq(@user)
    end

    it 'should return the proper record for email' do
      @user.email = Faker::Internet.email
      @user.save
      db_user = User.find_for_database_authentication(:login => @user.email)
      db_user.should eq(@user)
    end
  end

  describe 'hashed email' do
    it 'should return an md5 of the the user\'s email' do
      @user.email = Faker::Internet.email
      @user.hashed_email.should eq(Digest::MD5.hexdigest(@user.email))
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

end
