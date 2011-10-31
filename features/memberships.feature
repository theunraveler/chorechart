Feature: Managing group users
  In order to collaborate on chores
  As a group admin
  I want to add people to my groups
  
  Background: Create some groups
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    And the following users:
      | username  | email           |
      | susan     | susan@test.com  |
      | william   | will@test.com   |

  Scenario: Add an existing user to my group by email
    Given I am on the memberships page for the group "Company Office"
    When I fill in "Username or email" with "susan@test.com"
    And I press "Add user"
    Then I should be on the memberships page for the group "Company Office"
    And I should see the flash message "has been added"
    And I should see "susan@test.com" within the content area table

  Scenario: Can't add a user twice to the same group
    Given "susan" is a member of the group "Company Office"
    And I am on the memberships page for the group "Company Office"
    When I fill in "Username or email" with "susan"
    When I press "Add user"
    Then I should see the form error "is already part" for "Username or email"

  Scenario: Removing a user from a group
    Given "susan" is a member of the group "Company Office"
    And I am on the memberships page for the group "Company Office"
    When I remove the membership with name "susan"
    Then I should see the flash message "has been removed"
    And I should not see "susan (susan@test.com)" within the content area table
