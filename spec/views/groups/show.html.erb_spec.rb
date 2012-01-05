require 'spec_helper'

describe "groups/show.html.erb" do
  before(:each) do
    @group = FactoryGirl.create(:group)
    assign :group, @group
    assign :week, Date.current.beginning_of_week
    assign :assignments, {}
    stub_template "groups/_actions.html.erb" => ""
  end

  it 'should render a table column for each of the groups users' do
    @group.stub_chain(:users, :all).and_return([FactoryGirl.build(:user), FactoryGirl.build(:user)])
    render
    # 2 users + one filler column
    rendered.should have_selector('th', :count => 3)
  end

  it 'should render a table row for each day of the week'

end
