require 'spec_helper'

describe "chores/new.html.erb" do
  before(:each) do
    assign(:chore, stub_model(Chore,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new chore form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chores_path, :method => "post" do
      assert_select "input#chore_name", :name => "chore[name]"
    end
  end
end
