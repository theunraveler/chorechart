When /^I invite "([^"]*)" to join the group "([^"]*)"$/ do |email, group_name|
  Given %{I am on the new invitation page for the group "#{group_name}"}
  When %{I fill in "Email" with "#{email}"}
  And %{I press "Invite user"}
end

Given /^there is a pending invitation for "([^"]*)" to join the group "([^"]*)"$/ do |email, group_name|
  group = Group.find_by_name(group_name)
  FactoryGirl.create(:invitation, :email => email, :group_id => group.id)
end

Then /^"([^"]*)" should receive an invitation email$/ do |email|
  Then %{"#{email}" should receive an email}
  When %{I open the email}
  Then %{I should see "Join Chorechart!" in the email subject}
end

Then /^"([^"]*)" should not have an invitation for the group "([^"]*)"$/ do |email, group_name|
  group = Group.find_by_name(group_name)
  Invitation.find_all_by_email_and_group_id(email, group.id).empty?
end
