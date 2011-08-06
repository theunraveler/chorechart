Given /^I do not have a user account already$/ do
  User.delete_all
end

Given /^I have a user account with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  User.find_by_username(username).try(:delete)
  @user = FactoryGirl.create(:user, :username => username, :password => password)
  @password = password
end

Given /^I am logged in as "([^"]*)"$/ do |user|
  Given %{I have a user account with username "#{user}" and password "password"}
  When %{I go to the login page}
  And %{I enter my credentials}
end

When /^I enter "([^"]*)", "([^"]*)", and "([^"]*)" as my username, email, and password$/ do |username, email, password|
  fill_in('Username', :with => username)
  fill_in('Email', :with => email)
  fill_in('Password', :with => password)
  fill_in('Password confirmation', :with => password)
  click_button("Sign up")
end

When /^I enter my credentials$/ do
  fill_in('Email', :with => @user.email) 
  fill_in('Password', :with => @password) 
  click_button('Sign in')
end
