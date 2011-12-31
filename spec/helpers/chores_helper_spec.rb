require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ChoresHelper. For example:
#
# describe ChoresHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ChoresHelper do
  describe '#interval_select' do
    it 'should call #options_for_select' do
      helper.should_receive(:options_for_select)
      helper.interval_select
    end

    it 'should include the default argument if there is one' do
      helper.should_receive(:options_for_select).with(anything, 'week')
      helper.interval_select('week')
    end

    it 'should output options html tags' do
      helper.interval_select.should =~ /<option/
    end
  end
end
