require 'spec_helper'

describe Invitation do

  describe 'to string' do
    before do
      group = FactoryGirl.create(:group)
      @invitation = FactoryGirl.create(:invitation, :group_id => group.id)
    end

    it 'should be the email address' do
      @invitation.to_s.should eq(@invitation.email)
    end

  end

end
