require 'spec_helper'

describe SessionsController do
  before do
    @controller = SessionsController.new
  end

  describe 'choose layout' do
    it 'should render the application layout for all actions except :new' do
      ['index', 'hello', 'test', 'destroy', 'create'].each do |action|
        @controller.stubs(:action_name).returns(action)
        @controller.choose_layout.should eq('application')
      end
    end

    it 'should render no_sidebar layout for the :new action' do
      @controller.stubs(:action_name).returns('new')
      @controller.choose_layout.should eq('no_sidebar')
    end
  end
end
