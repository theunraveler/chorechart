Given /^I have attached my (.+) account$/ do |service|
  @user.authentications.create({:provider => service.downcase, :uid => '12345'})
end

When /^I delete my (.+) account$/ do |service|
  within(:xpath, "//div[@id='my-authentications']/div[div//text()[contains(., '#{service}')]]") do
    click_link('x')
  end
end

Then /^I should have (\d+) active authentications?$/ do |count|
  @user.authentications.count == count.to_i
end
