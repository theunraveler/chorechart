Given /^I have the following chores in "([^"]*)":$/ do |group_name, chores|
  group = Group.find_by_name(group_name)
  chores.hashes.each do |chore|
    chore[:group_id] = group.id
    FactoryGirl.create(:chore, chore)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) chores$/ do |pos|
  visit chores_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following chores:$/ do |expected_chores_table|
  expected_chores_table.diff!(tableish('table tr', 'td,th'))
end

Then /^I should see a weekly rule for today's day$/ do
  today = Date.today.strftime('%A').pluralize
  Then %{I should see "Weekly on #{today}"}
end
