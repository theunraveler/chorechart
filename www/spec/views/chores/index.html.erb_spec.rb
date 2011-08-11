require 'spec_helper'

describe "chores/index.html.erb" do
  before(:each) do
    assign(:chores, [
      stub_model(Chore,
        :name => "Name"
      ),
      stub_model(Chore,
        :name => "Name"
      )
    ])
  end

  it "renders a list of chores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
