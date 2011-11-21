require 'spec_helper'

describe GroupsController do
  login_user

  before(:all) do
    @group = FactoryGirl.build(:group)
  end
  before do
    Group.stub!(:find).with('1').and_return(@group)
  end

  describe 'GET /groups' do
    it 'should assign a @groups instance variable' do
      get :index
      assigns(:groups).should_not be_nil
    end
  end

  describe 'GET /groups/:id' do
    context 'has access' do
      before do
        GroupsController.any_instance.stub(:authorize!).and_return(true)
      end

      it 'should assign the week param to an instance variable' do
        week = Date.parse('15-08-2011')
        get :show, :id => 1, :week => week.to_s
        assigns(:week).should eq(week.beginning_of_week)
      end

      it 'should assign the current week to ivar if none is specified' do
        get :show, :id => 1
        assigns(:week).should eq(Date.today.beginning_of_week)
      end

      it 'should call assignments_for_grouped' do
        @group.should_receive(:assignments_for_grouped)
        get :show, :id => 1
      end
    end

    context 'does not have access' do
      it 'should return a 403' do
        get :show, :id => 1
        response.status.should eq(403)
      end
    end
  end

  describe 'DELETE /groups/:id' do
    context 'has access' do
      before do
        GroupsController.any_instance.stub(:authorize!).and_return(true)
      end

      it 'should delete the group' do
        @group.should_receive(:destroy).and_return(true)
        delete :destroy, :id => 1
      end

      it 'should set a flash message' do
        delete :destroy, :id => 1
        flash[:notice].should_not be_nil
      end
    end
  end
end
