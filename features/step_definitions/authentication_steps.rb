Given /^I have attached my (.+) account$/ do |service|
  @user.authentications.create(:provider => service.downcase, :uid => '12345')
end

Then /^I should have (\d+) authentication$/ do |count|
  @user.authentications.count == count.to_i
end
