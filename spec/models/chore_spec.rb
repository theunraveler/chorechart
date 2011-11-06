require 'spec_helper'

describe Chore do

  describe 'to string' do
    before do
      group = FactoryGirl.create(:group)
      @chore = FactoryGirl.create(:chore, :group_id => group.id)
    end

    it 'should be the chore name' do
      @chore.to_s.should eq(@chore.name)
    end

  end

end
