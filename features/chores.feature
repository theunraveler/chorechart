Feature: Manage chores
  In order to be able to manage chores assigned to a group
  As a user
  I want to be able to CRUD chores within a group
  
  Background: Create a couple groups
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |

  @broken
  Scenario: Create a new chore
    Given I am on the chore page for the group "Company Office"
    When I click "Create a chore"
    And I fill in "Name" with "Dishes"
    And I press "Create chore"
    Then I should be on the group page for "Company Office"
    And I should see the flash message "Chore Dishes created."
    And I should see "Laundry" within the content area table
