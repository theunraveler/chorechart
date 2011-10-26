Given /^I have no (.+)$/ do |model|
  model.classify.constantize.delete_all
end

When /^I click o?n?\s?"([^"]*)"$/ do |link|
  When %{I follow "#{link}"} 
end

Then /^I should be taken to (.+)$/ do |page_name|
  Then "I should be on #{page_name}"
end

Then /^I should see the flash message "([^"]*)"$/ do |message|
  Then %{I should see "#{message}" within "#flash"}
end
