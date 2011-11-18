require 'spec_helper'

describe 'email validator' do
  before do
    @user = FactoryGirl.build(:user)
  end

  ['test', 'test@', '@test.com', 'test@test', 'test@test.', '.com'].each do |email|
    it "catches invalid emails (#{email})" do
      @user.email = email
      @user.save
      @user.errors[:email].count.should eq(1)
    end
  end

  it "allows valid emails" do
    @user.email = Faker::Internet.email
    @user.save
    @user.errors[:email].count.should eq(0)
  end

end
