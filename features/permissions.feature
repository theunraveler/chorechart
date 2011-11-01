Feature: Permissioning
  In order to restrict access to group management
  As a user
  I was to have proper access control

  Background: Create some groups
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name  |
      | Household   |
      | Office      |

  @focus
  Scenario Outline:
    Given I am logged in as "susan"
    And "susan" is a member of the group "Office"
    When I go to <path>
    Then show me the page
    Then I should see "don't have access"

    Scenarios:
      | path                                            |
      | the memberships page for the group "Office"     |
      | the chores page for the group "Office"          |
      | the "edit" page for the group "Company Office"  |
