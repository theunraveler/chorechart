require 'spec_helper'

describe Authentication do
  before do
    @authentication = FactoryGirl.build(:authentication)
  end

  describe 'to string' do
    it 'should return "Google" for the provider "google_oauth2"' do
      @authentication.provider = 'google_oauth2'
      @authentication.to_s.should eq('Google')
    end

    ['hello', 'twitter', 'test string', 'Test-string'].each do |term|
      it "should return a titlized string for all others (#{term})" do
        @authentication.provider = term
        @authentication.to_s.should eq(term.titleize)
      end
    end
  end

end
