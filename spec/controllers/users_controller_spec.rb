require 'spec_helper'

describe UsersController do
  login_user

  describe 'GET /dashboard' do
    it 'should assign the current_user to an instance variable' do
      get :dashboard
      assigns(:user).should eq(@user)
    end
  end
end
