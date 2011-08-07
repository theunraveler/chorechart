Given /^the following groups exist:$/ do |table|
  @groups = []
  table.hashes.each do |hash|  
    map = { 'Group Name' => 'name' }
    subbed = Hash[hash.map {|k, v| [map[k], v] }]
    @groups << FactoryGirl.create(:group, subbed)
  end
end

Then /^I should only see my groups$/ do
  @user.groups.each do |group|
    Then %{I should see "#{group.name}" within the content area}
  end
  
end

Then /^"([^"]*)" should be among my groups$/ do |group|
  Then %{I should see "#{group}" within the content area}
end
