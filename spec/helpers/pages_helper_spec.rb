require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ChoresHelper. For example:
#
# describe PagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe PagesHelper do
  describe '#image_thumb_tag' do
    it 'should properly substitute the thumbnail filepath' do
      helper.should_receive(:image_tag).with('hello-thumb.png', anything)
      helper.image_thumb_tag('hello.png')
    end

    it 'should ultimately output a link' do
      helper.image_thumb_tag('hello.png').should =~ /<a href/
    end

    it 'should open in a lightbox' do
      helper.image_thumb_tag('hello.png').should =~ /rel="lightbox"/
    end
  end
end
