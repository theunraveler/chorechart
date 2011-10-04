Given /^the following groups exist:$/ do |table|
  @groups ||= []
  table.hashes.each do |hash|  
    map = { 'Group Name' => 'name' }
    subbed = Hash[hash.map {|k, v| [map[k], v] }]
    @groups << FactoryGirl.create(:group, subbed)
  end
end

Given /^I own the following groups:$/ do |table|
  @groups ||= []
  table.hashes.each do |hash|  
    map = { 'Group Name' => 'name' }
    subbed = Hash[hash.map {|k, v| [map[k], v] }]
    group = FactoryGirl.create(:group, subbed)
    @groups << group
    @user.memberships.create(:group => group, :is_admin => true)
  end
end

Then /^I should only see my groups$/ do
  @user.groups.each do |group|
    Then %{I should see "#{group.name}" within the content area}
  end
  # TODO: Check for other groups
end

When /^I edit the (.*) with name "([^"]*)"$/ do |class_name, value|
  object = class_name.capitalize.constantize.find_by_name(value)
  visit "/#{class_name.pluralize}/#{object.id}/edit"
end

Then /^"([^"]*)" should be among my groups$/ do |group|
  Then %{I should see "#{group}" within the content area}
end

Then /^"([^"]*)" should not be among my groups$/ do |group|
  Then %{I should not see "#{group}" within the content area}
end
