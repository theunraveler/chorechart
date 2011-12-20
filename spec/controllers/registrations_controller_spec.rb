require 'spec_helper'

describe RegistrationsController do
  before(:all) do
    @controller = RegistrationsController.new
  end

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'registrations#new' do
    it 'should assign @amniauth to true if present in the session' do
      session.stub!(:has_key?).and_return(true)
      get :new
      assigns(:omniauth).should be_true
    end

    it 'should assign @amniauth to false if not' do
      session.stub!(:has_key?).and_return(false)
      get :new
      assigns(:omniauth).should be_false
    end
  end
end
