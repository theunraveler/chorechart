Given /^I do not have a user account\s?a?l?r?e?a?d?y?$/ do
  User.delete_all
end

Given /^the following users:$/ do |users|
  users.hashes.each do |user|
    FactoryGirl.create(:user, user)
  end
end

Given /^I have a user account with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  step %{there is no user account for the username "#{username}"}
  @user = FactoryGirl.create(:user, :username => username, :password => password)
  @password = password
end

Given /^there is no user account for the (.*) "([^"]*)"$/ do |property, value|
  User.send("find_by_#{property.gsub(' ', '_')}", value).try(:delete)
end

Given /^I am logged in as "([^"]*)"$/ do |username|
  unless @user.nil?
    step %{I am logged out}
  end

  if user = User.find_by_login(username).first
    @user = user
  else
    step %{I have a user account with username "#{username}" and password "password"}
  end
  step %{I go to the login page}
  step %{I enter my credentials}
end

Given /^I am logged out$/ do
  click_link('Log out')
end

Given /^my time zone is set to "([^"]*)"$/ do |zone|
  @user.time_zone = zone
  @user.save!
end

When /^I enter "([^"]*)", "([^"]*)", and "([^"]*)" as my username, email, and password$/ do |username, email, password|
  fill_in('Username', :with => username)
  fill_in('Email', :with => email)
  fill_in('Password', :with => password)
  fill_in('Password confirmation', :with => password)
  click_button("Register")
end

When /^I enter my credentials$/ do
  fill_in('Email', :with => @user.email) 
  fill_in('Password', :with => @password) 
  click_button('Log in')
end

When /^I change my time zone to "([^"]*)"$/ do |zone|
  step %{my time zone is set to "#{zone}"}
end
  
Then /^I should see my username$/ do
  step %{I should see "#{@user}"}
end

Then /^I should not see my username$/ do
  step %{I should not see "#{@user}"}
end

Then /^I should see my avatar$/ do
  hash = Digest::MD5.hexdigest(@user.email.strip)
  page.body.should include(%{src="http://www.gravatar.com/avatar/#{hash}})
end

Then /^my account should be deleted$/ do
  User.where(:id => @user.id).empty?
end
