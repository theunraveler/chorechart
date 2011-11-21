require 'spec_helper'

describe 'email validator' do
  before do
    @invitation = FactoryGirl.build(:invitation)
  end

  ['test', 'test@', '@test.com', 'test@test', 'test@test.', '.com'].each do |email|
    it "catches invalid emails (#{email})" do
      @invitation.email = email
      @invitation.save
      @invitation.errors[:email].count.should eq(1)
    end
  end

  it "allows valid emails" do
    @invitation.email = Faker::Internet.email
    @invitation.save
    @invitation.errors[:email].count.should eq(0)
  end

end
