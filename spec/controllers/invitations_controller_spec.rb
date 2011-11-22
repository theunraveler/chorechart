require 'spec_helper'

describe InvitationsController do
  login_user

  describe 'GET /group/:group_id/invitations/new' do
    before(:all) do
      @group = FactoryGirl.build(:group)
    end
    before do
      InvitationsController.any_instance.stub(:authorize!).and_return(true)
      Group.stub!(:find).with('1').and_return(@group)
    end

    it 'should assign a @group ivar' do
      get :new, :group_id => 1
      assigns(:group).should be_an_instance_of(Group)
    end

    it 'should build a new @invitation' do
      get :new, :group_id => 1
      assigns(:invitation).should be_an_instance_of(Invitation)
      assigns(:invitation).should be_new_record
    end
  end
end
