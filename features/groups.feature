Feature: Groups
  In order to share chores with other users
  As a user
  I want to maintain groups, to which I can invite other users

  Scenario: Creating an account
    Given I am logged in as "test_user"
    When I go to my user page
    And I click on "Create a group"
    And I fill in the following:
      | Group Name | New Test Group |
    Then I should be taken to my user page
    And I should see the flash message "Group New Test Group created."
