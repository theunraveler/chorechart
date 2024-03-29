# web_steps.rb used to be in Cucumber-Rails, but was removed in 1.1.0. We're still using them in the tests because
# the tests were written while we still thought web_steps.rb was a good idea. We don't think so anymore:
#
#    http://groups.google.com/group/cukes/browse_thread/thread/26f80b93c94f2952
#    https://github.com/cucumber/cucumber-rails/issues/174
#    http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
#    http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
#    http://elabs.se/blog/15-you-re-cuking-it-wrong
#
# I'm sure someone will find this and paste it into their own projects. Go ahead. It's a bad idea.
# You have been warned.
#
# Aslak

require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |the_step, parent|
  with_scope(parent) { step the_step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |the_step, parent, table_or_string|
  with_scope(parent) { step "#{the_step}:", table_or_string }
end

Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    step %{I fill in "#{name}" with "#{value}"}
  end
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I check "([^"]*)"$/ do |field|
  check(field)
end

When /^I uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^I choose "([^"]*)"$/ do |field|
  choose(field)
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "([^"]*)"$/ do |text|
  page.should have_no_content(text)
end

Then /^I should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^show me the page$/ do
  save_and_open_page
end
