require 'spec_helper'

describe 'routing to groups' do
  it 'routes /groups to group#index' do
    { :get => '/groups' }.should route_to(
      :controller => 'groups',
      :action => 'index',
    )
  end

  it 'routes /groups/:id to group#show for id' do
    { :get => '/groups/2' }.should route_to(
      :controller => 'groups',
      :action => 'show',
      :id => '2'
    )
  end
end
