require 'spec_helper'

describe 'routing to memberships' do
  it 'routes /groups/:group_id/memberships to memberships#index for group' do
    { :get => '/groups/2/memberships' }.should route_to(
      :controller => 'memberships',
      :action => 'index',
      :group_id => '2'
    )
  end

  it 'has a create route at /groups/:group_id/memberships' do
    { :post => '/groups/2/memberships' }.should route_to(
      :controller => 'memberships',
      :action => 'create',
      :group_id => '2'
    )
  end

  it 'has a shallow destroy route at /memberships/:id' do
    { :delete => '/memberships/1' }.should route_to(
      :controller => 'memberships',
      :action => 'destroy',
      :id => '1'
    )
  end

  it 'does not have an edit route (shallow or nested)' do
    { :get => '/memberships/1/edit' }.should_not be_routable
    { :get => '/groups/1/memberships/1/edit' }.should_not be_routable
  end

  it 'does not have a new route (shallow or nested)' do
    { :get => '/memberships/new' }.should_not be_routable
    { :get => '/groups/1/memberships/new' }.should_not be_routable
  end

  it 'does not have a show route (shallow or nested)' do
    { :get => '/memberships/1' }.should_not be_routable
    { :get => '/groups/1/memberships/1' }.should_not be_routable
  end
  
  it 'does not have an update route (shallow or nested)' do
    { :put => '/memberships/1' }.should_not be_routable
    { :put => '/groups/1/memberships/1' }.should_not be_routable
  end
end
