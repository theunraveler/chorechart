require 'spec_helper'

describe Invitation do

  describe 'to string' do
    before do
      @invitation = FactoryGirl.build(:invitation)
    end

    it 'should be the email address' do
      @invitation.to_s.should eq(@invitation.email)
    end

  end

end
