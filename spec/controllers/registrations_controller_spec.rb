require 'spec_helper'

describe RegistrationsController do
  before(:all) do
    @controller = RegistrationsController.new
  end

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'choose layout' do
    it 'should render the application layout for all actions except :new' do
      ['index', 'hello', 'test', 'destroy', 'create'].each do |action|
        @controller.stub!(:action_name).and_return(action)
        @controller.choose_layout.should eq('application')
      end
    end

    it 'should render no_sidebar layout for the :new action' do
      @controller.stub!(:action_name).and_return('new')
      @controller.choose_layout.should eq('no_sidebar')
    end
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
