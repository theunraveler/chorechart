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

Given /^the group "([^"]*)" has the following chores:$/ do |group_name, chores|
  group = Group.find_by_name(group_name)
  chores.hashes.each do |chore|
    chore[:group_id] = group.id
    FactoryGirl.create(:chore, chore)
  end
end

Then /^I should only see my groups$/ do
  @user.groups.each do |group|
    step %{I should see "#{group}" within the content area table}
  end
  (@groups - @user.groups).each do |group|
    step %{I should not see "#{group}" within the content area}
  end
end

Then /^"([^"]*)" should be among my groups$/ do |group|
  step %{I should see "#{group}" within the content area table}
end

Then /^"([^"]*)" should not be among my groups$/ do |group|
  step %{I should not see "#{group}" within the content area table}
end
