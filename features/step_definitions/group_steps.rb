Given /^I have the following groups:$/ do |table|
  @groups = []
  table.hashes.each do |hash|  
    map = { 'Group Name' => 'name' }
    subbed = Hash[hash.map {|k, v| [map[k], v] }]
    @groups << FactoryGirl.create(:group, subbed)
  end
  @user.groups = @groups
  @user.save
end

Then /^I should see all of my groups$/ do
  @user.groups.each do |group|
    Then %{I should see "#{group.name}" within the content area}
  end
  
end

Then /^"([^"]*)" should be among my groups$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
