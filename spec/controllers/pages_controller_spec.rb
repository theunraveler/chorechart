require 'spec_helper'

describe PagesController do
  describe 'GET #homepage' do
    context 'when user logged in' do
      login_user

      it 'should redirect to dashboard' do
        get :homepage
        response.should redirect_to(user_root_path)
      end
    end

    context 'when anonymous user' do
      it 'not redirect if the user is anonymous' do
        get :homepage
        response.should_not redirect_to
      end
    end
  end
end
