Feature: Groups
  In order to share chores with other users
  As a user
  I want to maintain groups, to which I can invite other users

  Scenario: Viewing my groups
    Given I am logged in as "test_user"
    And the following groups exist:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    When I click "Manage Groups"
    Then I should be on my groups page
    And I should only see my groups

  Scenario: Creating a group
    Given I am logged in as "test_user"
    When I go to my groups page
    And I click on "New Group"
    And I fill in the following:
      | Name | New Test Group |
    And I press "Create group"
    Then I should be taken to my groups page
    And I should see the flash message "Group New Test Group created."
    And "New Test Group" should be among my groups

  Scenario: Editing a group
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    When I edit the group with name "Company Office"
    And I fill in "Name" with "Company Kitchen"
    And I press "Save"
    Then I should be taken to my groups page
    And I should see the flash message "Group Company Kitchen was successfully updated."
    And "Company Kitchen" should be among my groups
    And "Company Office" should not be among my groups
