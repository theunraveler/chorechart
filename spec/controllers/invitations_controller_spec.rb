require 'spec_helper'

describe InvitationsController do
  login_user
  before(:all) do
    @group = FactoryGirl.build(:group, :id => 1)
  end
  before do
    Group.stub!(:find).with('1').and_return(@group)
    InvitationsController.any_instance.stub(:authorize!).and_return(true)
  end

  describe 'GET /group/:group_id/invitations/new' do

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

  describe 'POST /groups/:group_id/invitations' do
    it 'should redirect to the group membership page with a flash message when successful' do
      Invitation.any_instance.stub(:valid?).and_return(true)
      Notifier.stub_chain(:invite, :deliver)
      Notifier.should_receive(:invite)
      post :create, :group_id => 1
      assigns(:invitation).should_not be_new_record
      flash[:notice].should_not be_nil
      response.should redirect_to(group_memberships_path(@group.id))
    end

    it 'should not create flash on failed save' do
      Invitation.any_instance.stub(:valid?).and_return(false)
      post :create, :group_id => 1
      assigns(:invitation).should be_new_record
      flash[:notice].should be_nil
    end

    it 'should pass parameter values' do
      email = Faker::Internet.email
      post :create, :group_id => 1, :invitation => { :email => email }
      assigns(:invitation).email.should eq(email)
    end
  end

  describe 'DELETE /invitations/:id' do
    before do
      @invitation = FactoryGirl.build(:invitation)
      Invitation.stub!(:find).and_return(@invitation)
    end

    it 'should delete the record, set a flash message, and redirect' do
      @invitation.should_receive(:destroy)
      delete :destroy, :id => 1
      flash[:notice].should_not be_nil
      response.should redirect_to(group_memberships_path(@invitation.group_id))
    end
  end
end
