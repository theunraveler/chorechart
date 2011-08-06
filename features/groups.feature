Feature: Groups
  In order to share chores with other users
  As a user
  I want to maintain groups, to which I can invite other users

  Scenario: Viewing my groups
    Given I am logged in as "test_user"
    And I have the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    When I click "My Groups"
    Then I should be on my groups page
    And I should see all of my groups

  Scenario: Creating an account
    Given I am logged in as "test_user"
    When I go to my groups page
    And I click on "Create a group"
    And I fill in the following:
      | Group Name | New Test Group |
    And I press "Create Group"
    Then I should be taken to my groups page
    And I should see the flash message "Group New Test Group created."
    And "New Test Group" should be among my groups
