Given /^I have no (.+)$/ do |model|
  model.classify.constantize.delete_all
end

When /^I click o?n?\s?"([^"]*)"$/ do |link|
  click_link(link)
end

When /^I (.*) the (.*) with name "([^"]*)"$/ do |action, class_name, value|
  within(:xpath, "//table//tr[td//text()[contains(., '#{value}')]]") do
    click_link(action.capitalize)
  end
end

Then /^I should be taken to (.+)$/ do |page_name|
  Then "I should be on #{page_name}"
end

Then /^I should see the flash message "([^"]*)"$/ do |message|
  within '#flash' do
    Then %{I should see "#{message}"}
  end
end

Then /^I should see an image with alt text "([^\"]*)"$/ do |alt_text|
  has_xpath?("//img[contains(@alt,\"#{alt_text}\")]")
end

Then /^I should not see an image with alt text "([^\"]*)"$/ do |alt_text|
  !has_xpath?("//img[contains(@alt,\"#{alt_text}\")]")
end

Then /^I should see the form error "([^"]*)" for "([^"]*)"$/ do |message, field|
  within(:xpath, "//form/div[label//text()[contains(., '#{field}')]]") do
    Then %{I should see "#{message}"}
  end
end

Then /^I should have (\d+) ([^\s]*)$/ do |number, model|
  model.classify.constantize.count == number.to_i
end
