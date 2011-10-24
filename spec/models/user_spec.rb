require 'spec_helper'

describe User do
  
  describe "last name" do
    before(:all) do
      @user = FactoryGirl.create(:user, :name => 'Benjamin Franklin')
    end

    it "should display the user's last name if one exists" do
      @user.last_name.should eq('Franklin')
    end

    it "should return nil if the user has no name" do
      @user.name = ''
      @user.last_name.should be_nil
    end

    after(:all) do
      @user.delete
    end
  end

end
