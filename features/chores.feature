Feature: Chores
  In order to manage chores
  As a user
  I want to be able to CRUD chores within a group
  
  Background: Create a couple groups
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |

  Scenario: Create a new chore
    Given I am on the chore page for the group "Company Office"
    When I click "Create a chore"
    And I fill in "Name" with "Dishes"
    And I press "Create chore"
    Then I should be on the chores page for the group "Company Office"
    And I should see the flash message "Chore Dishes was successfully created."
    And I should see "Dishes" within the content area table

  @focus
  Scenario: Creating a weekly chore with no days
    Given I am on the chore page for the group "Company Office"
    When I click "Create a chore"
    And I fill in "Name" with "Laundry"
    And I select "week(s)" from "chore[schedule_attributes][interval_unit]"
    And I press "Create chore"
    Then I should be on the chores page for the group "Company Office"
    And I should see the flash message "Chore Laundry was successfully created."
    And I should see "Laundry" within the content area table
    And I should see a weekly rule for today's day within the content area table
