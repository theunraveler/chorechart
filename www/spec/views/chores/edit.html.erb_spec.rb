require 'spec_helper'

describe "chores/edit.html.erb" do
  before(:each) do
    @chore = assign(:chore, stub_model(Chore,
      :name => "MyString"
    ))
  end

  it "renders the edit chore form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chores_path(@chore), :method => "post" do
      assert_select "input#chore_name", :name => "chore[name]"
    end
  end
end
