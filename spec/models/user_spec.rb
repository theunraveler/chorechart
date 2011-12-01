require 'spec_helper'

describe User do
  
  before do
    @user = FactoryGirl.build(:user, :name => 'Benjamin Franklin')
  end

  describe '#update_with_password' do
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

  describe '#first_name' do
    it "should display the user's first name if one exists" do
      @user.first_name.should eq('Benjamin')
    end

    it "should return nil if the user has no name" do
      @user.name = ''
      @user.first_name.should be_nil
    end
  end

  describe '#assignments_for' do
    before do
      5.times { @user.groups << FactoryGirl.build(:group) }
    end

    it 'should call assignments_for for each group' do
      @user.groups.each do |group|
        group.stub!(:assignments_for).and_return([])
        group.should_receive(:assignments_for)
      end
      @user.assignments_for
    end

    it 'should concatenate an array of assignments' do
      @user.groups.each do |group|
        group.stub!(:assignments_for).and_return([FactoryGirl.build(:assignment, :user => @user)])
      end
      assignments = @user.assignments_for
      assignments.count.should eq(5)
      assignments.all? { |a| a.is_a?(Assignment) }.should be_true
    end

    it 'should only return assignments that belong to the user' do
      @user.groups[0..2].each do |group|
        group.stub!(:assignments_for).and_return([FactoryGirl.build(:assignment, :user => @user)])
      end
      @user.groups[3..-1].each do |group|
        group.stub!(:assignments_for).and_return([FactoryGirl.build(:assignment)])
      end
      @user.assignments_for.count.should eq(3)
    end
  end

  describe '#apply_omniauth' do
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

  describe '#fill_password' do
    it 'should generate a six-character password' do
      @user.fill_password
      @user.password.length.should eq(6)
    end

    it 'should set the password and password confirmation attributes' do
      @user.fill_password
      @user.password.should eq(@user.password_confirmation)
    end
  end

  describe '#find_for_database_authentication' do
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

  describe '#hashed_email' do
    it 'should return an md5 of the the user\'s email' do
      @user.email = Faker::Internet.email
      @user.hashed_email.should eq(Digest::MD5.hexdigest(@user.email))
    end
  end

  describe '#to_s' do
    it "should return the user's first name if they have one" do
      @user.to_s.should eq(@user.first_name)
    end

    it 'should return the username otherwise' do
      @user.name = nil
      @user.to_s.should eq(@user.username)
    end
  end

  describe '#process_pending_invitations' do
    before do
      @invitations = []
      2.times { @invitations << FactoryGirl.build(:invitation) }
      Invitation.stub!(:find_all_by_email).and_return(@invitations)
      @user.stub_chain(:memberships, :create).and_return(true)
    end

    it 'should find all invitations by the user\'s email' do
      Invitation.should_receive(:find_all_by_email).with(@user.email)
      @user.send(:process_pending_invitations)
    end

    it 'should create a new membership for each invitation' do
      @user.memberships.should_receive(:create).twice
      @user.send(:process_pending_invitations)
    end

    it 'should delete all invitations' do
      @invitations.each { |i| i.should_receive(:destroy) }
      @user.send(:process_pending_invitations)
    end
  end

end
