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

  Scenario Outline: Non-admins cannot do stuff to a group
    Given I am logged in as "susan"
    And "susan" is a member of the group "Office"
    When I go to <path>
    Then I should see the Access Denied page

    Scenarios:
      | path                                            |
      | the memberships page for the group "Office"     |
      | the chores page for the group "Office"          |
      | the "edit" page for the group "Office"          |

  Scenario: Non-admins should not see the "Manage" link
    Given I am logged in as "susan"
    And "susan" is a member of the group "Office"
    When I go to the group page for "Office"
    Then I should not see the manage link

  Scenario Outline: Admins cannot see or manage resources for groups they aren't in
    Given the following groups exist:
      | Group Name      |
      | Shop            |
      | Practice Space  |
    When I go to <path>
    Then I should see the Access Denied page

    Scenarios:
      | path                                      |
      | the group page for "Shop"                 |
      | the group page for "Practice Space"       |
      | the memberships page for the group "Shop" |
      | the chores page for the group "Shop"      |
