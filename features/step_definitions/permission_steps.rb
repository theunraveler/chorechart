Then /^I should not see the manage link$/ do
  step %{I should not see "Manage" within the content area}
end

Then /^I should see the Access Denied page$/ do
  step %{I should see "don't have access"}
end
