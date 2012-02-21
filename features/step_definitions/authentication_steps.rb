Given /^I have attached my (.+) account$/ do |service|
  @user.authentications.create({:provider => service.downcase, :uid => '12345'})
end

When /^I log in with "([^"]*)"$/ do |service|
  auth = Authentication.find_by_provider_and_user_id(service.downcase, @user.id)
  step %{I click on "#{auth}"}
end

When /^I delete my (.+) account$/ do |service|
  auth = Authentication.find_by_provider_and_user_id(service.downcase, @user.id)
  within(:xpath, "//div[@id='my-authentications']/div[div//text()[contains(., '#{auth}')]]") do
    find('.close').click
  end
end

Then /^I should have (\d+) active authentications?$/ do |count|
  @user.authentications.count == count.to_i
end
