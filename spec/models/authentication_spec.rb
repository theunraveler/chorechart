require 'spec_helper'

describe Authentication do
  before do
    @authentication = FactoryGirl.build(:authentication)
  end

  describe 'provider name' do
    it 'should return "Google" for the provider "google_oauth2"' do
      @authentication.provider = 'google_oauth2'
      @authentication.provider_name.should eq('Google')
    end

    ['hello', 'twitter', 'test string', 'Test-string'].each do |term|
      it "should return a titlized string for all others (#{term})" do
        @authentication.provider = term
        @authentication.provider_name.should eq(term.titleize)
      end
    end
  end

end
