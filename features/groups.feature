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
    And I click on "Create a group"
    And I fill in the following:
      | Name | New Test Group |
    And I press "Create group"
    Then I should be taken to my groups page
    And I should see the flash message "Group New Test Group created."
    And "New Test Group" should be among my groups

  @bogus
  Scenario: Groups must have a name
    Given I am logged in as "test_user"
    When I go to my groups page
    And I click on "Create a group"
    And I press "Create group"
    Then I should see the form error "can't be blank" for "Name"
    And I should have 0 groups

  Scenario: Editing a group
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    And I am on my groups page
    When I edit the group with name "Company Office"
    And I fill in "Name" with "Company Kitchen"
    And I press "Save"
    Then I should be taken to my groups page
    And I should see the flash message "Group Company Kitchen was successfully updated."
    And "Company Kitchen" should be among my groups
    And "Company Office" should not be among my groups

  Scenario: Groups must have a name when updating
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    And I am on the "edit" page for the group "Company Office"
    When I fill in "Name" with ""
    And I press "Save"
    Then I should see the form error "can't be blank" for "Name"

  Scenario: Deleting a group
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    And I am on my groups page
    When I delete the group with name "Company Office"
    Then I should be taken to my groups page
    And I should see the flash message "Group Company Office deleted."
    And "Company Office" should not be among my groups

  Scenario: I can download a PDF of my weekly chores
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Company Office  |
    And the group "Company Office" has the following chores:
      | name    |
      | Laundry |
      | Dishes  |
    And I am on the group page for "Company Office"
    When I click on the PDF link "Download printable PDF"
    Then I should see "Company Office for the week of"
