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

  @bogus
  Scenario: Create a new chore with bogus information
    Given I am on the chore page for the group "Company Office"
    When I click "Create a chore"
    And I fill in "Name" with ""
    And I press "Create chore"
    Then I should see the form error "can't be blank" for "Name"

  Scenario: Creating a weekly chore with days
    Given I am on the chore page for the group "Company Office"
    When I click "Create a chore"
    And I fill in "Name" with "Cat boxes"
    And I select "week(s)" from "chore[schedule_attributes][interval_unit]"
    And I check "Tuesday"
    And I check "Saturday"
    And I press "Create chore"
    Then I should be on the chores page for the group "Company Office"
    And I should see the flash message "Chore Cat boxes was successfully created."
    And I should see "Cat boxes" within the content area table
    And I should see "Weekly on Tuesdays and Saturdays" within the content area table

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

  Scenario: Editing a chore as an admin
    Given I have the following chores in "Company Office":
      | name      |
      | Laundry   |
      | Dishes    |
      | Cat boxes |
    And I am on the chores page for the group "Company Office"
    When I edit the chore with name "Laundry"
    And I fill in "Name" with "Sweep the floors"
    And I press "Save"
    Then I should be on the chores page for the group "Company Office"
    And I should see "Sweep the floors" within the content area table
    And I should not see "Laundry" within the content area table

  @bogus
  Scenario: Editing a chore with bogus information
    Given I have the following chores in "Company Office":
      | name      |
      | Laundry   |
      | Dishes    |
      | Cat boxes |
    And I am on the chores page for the group "Company Office"
    When I edit the chore with name "Laundry"
    And I fill in "Name" with ""
    And I press "Save"
    Then I should see the form error "can't be blank" for "Name"

  Scenario: Deleting a chore as an admin
    Given I have the following chores in "Company Office":
      | name      |
      | Laundry   |
      | Dishes    |
      | Cat boxes |
    And I am on the chores page for the group "Company Office"
    When I delete the chore with name "Laundry"
    Then I should be on the chores page for the group "Company Office"
    And I should not see "Laundry" within the content area table

  @focus @wip
  Scenario: Sidebar chore listing time zone stuff
    Given I have the following chores in "Company Office":
      | name      | schedule      |
      | Laundry   | every 2 days  |
    And my time zone is set to "Central Time (US & Canada)"
    And I am on the dashboard
    When I go to the group page for "Company Office"
    Then I should see "Laundry" as my chore for today
    And I should have no chores tomorrow
    When I change my time zone to "Tokyo"
    Then I should have no chores today
    And I should see "Laundry" as my chore for tomorrow
