When /^I invite "([^"]*)" to join the group "([^"]*)"$/ do |email, group_name|
  step %{I am on the new invitation page for the group "#{group_name}"}
  step %{I fill in "Email" with "#{email}"}
  step %{I press "Invite user"}
end

Given /^there is a pending invitation for "([^"]*)" to join the group "([^"]*)"$/ do |email, group_name|
  group = Group.find_by_name(group_name)
  FactoryGirl.create(:invitation, :email => email, :group_id => group.id)
end

Then /^"([^"]*)" should receive an invitation email$/ do |email|
  step %{"#{email}" should receive an email}
  step %{I open the email}
  step %{I should see "Join Chorechart!" in the email subject}
end

Then /^"([^"]*)" should not have an invitation for the group "([^"]*)"$/ do |email, group_name|
  group = Group.find_by_name(group_name)
  Invitation.find_all_by_email_and_group_id(email, group.id).empty?
end

Then /^I should belong to the group "([^"]*)"$/ do |group_name|
  @user.groups.collect(&:name).include?(group_name)
end
