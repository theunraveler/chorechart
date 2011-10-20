Feature: Invite users to groups
  In order to add users to my groups
  As a group admin
  I want to send emails to users inviting them to join
  
  Background: Create a couple groups
    Given I am logged in as "test_user"
    And I own the following groups:
      | Group Name      |
      | Home            |
      | Company Office  |
      | Art Space       |
    And there is no user account for the email "user-doesnt-exist@test.com"

  Scenario: Invite a user when they are not found
    Given I am on the membership page for the group "Company Office"
    When I fill in "Username or email" with "user-doesnt-exist@test.com"
    And I check "Admin"
    And I press "Add user"
    Then I should be on the membership page for the group "Company Office"
    And I should see the flash message "Care to invite them?"
    When I click "Care to invite them?"
    And I fill in "Email" with "user-doesnt-exist@test.com"
    And I press "Invite user"
    Then I should see the flash message "user-doesnt-exist@test.com has been invited to join your group Company Office"
    When I go to the membership page for the group "Company Office"
    Then I should see "user-doesnt-exist@test.com (Pending)" within the content area table

  Scenario: User gets emailed when invited to a group
    When I invite "user-doesnt-exist@test.com" to join the group "Company Office"
    Then "user-doesnt-exist@test.com" should receive an invitation email
    And I should see "/account/register" in the email body

  @focus
  Scenario: User is automatically added to a group when registering
    Given there is a pending invitation for "user-doesnt-exist@test.com" to join the group "Company Office"

