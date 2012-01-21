require 'spec_helper'

describe PagesController do
  describe '#homepage' do
    context 'when user is logged in' do
      login_user

      it 'should redirect to dashboard' do
        get :homepage
        response.should redirect_to(user_root_path)
      end
    end

    context 'when anonymous user' do
      it 'should not redirect' do
        get :homepage
        response.should_not redirect_to(user_root_path)
      end
    end
  end
end
