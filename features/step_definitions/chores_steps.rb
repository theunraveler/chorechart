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
  today = Date.current.strftime('%A').pluralize
  step %{I should see "Weekly on #{today}"}
end

Then /^I should see "([^"]*)" as my chore for (.+)$/ do |chore, day|
  group = Group.find_by_name('Company Office')
  puts group.chores.inspect
  map = { 'today' => 1, 'tomorrow' => 2 }
  position = map[day]
  within("#my-chores div.chore-day:nth-child(#{position})") do
    page.should have_content(chore)
  end
end

Then /^I should have no chores (.+)$/ do |day|
  map = { 'today' => 1, 'tomorrow' => 2 }
  position = map[day]
  within("#my-chores div.chore-day:nth-child(#{position})") do
    page.should have_content('Nothing')
  end
end
