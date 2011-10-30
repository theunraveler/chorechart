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

  @focus
  Scenario: Add an existing user to my group by email
    Given I am on the group page for "Company Office"
    When I click on "Manage Users"
    And I fill in "Username or email" with "susan@test.com"
    And I press "Add user"
    Then I should be on the memberships page for the group "Company Office"
    And I should see the flash message "susan@test.com has been added"
    And I should see "susan@test.com" within the content area table
