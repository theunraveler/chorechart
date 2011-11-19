require 'spec_helper'
require 'email_spec'
include EmailSpec::Helpers
include EmailSpec::Matchers

describe Notifier do
  describe 'invitation email' do
    before(:all) do
      @address, @group, @user = Faker::Internet.email, FactoryGirl.build(:group), FactoryGirl.build(:user)
      @email = Notifier.invite(@address, @group, @user)
    end

    it 'should be sent to the specified email address' do
      @email.should deliver_to(@address)
    end

    it 'should have a certain subject' do
      @email.should have_subject(/Join Chorechart/)
    end
  end
end
