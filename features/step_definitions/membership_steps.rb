Given /^"([^"]*)" is a member of the group "([^"]*)"$/ do |username, group_name|
  user = User.find_by_login(username).first
  group = Group.find_by_name(group_name)
  FactoryGirl.create(:membership, :group => group, :user => user)
end
