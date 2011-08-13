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
  
Then /^I should see my username$/ do
  Then %{I should see "#{@user.username}"}
end

Then /^I should not see my username$/ do
  Then %{I should not see "#{@user.username}"}
end

Then /^I should see my avatar$/ do
  hash = Digest::MD5.hexdigest(@user.email.strip)
  page.body.should include(%{src="http://www.gravatar.com/avatar/#{hash}})
end

Then /^my account should be deleted$/ do
  User.where(:id => @user.id).empty?
end
