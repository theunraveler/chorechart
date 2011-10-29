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

  Scenario: User is automatically added to a group when registering
    Given there is a pending invitation for "user-doesnt-exist@test.com" to join the group "Company Office"
    And I am logged out
    And I am on the new user registration page
    When I enter "new_user", "user-doesnt-exist@test.com", and "password" as my username, email, and password
    Then I should belong to the group "Company Office"
    And "user-doesnt-exist@test.com" should not have an invitation for the group "Company Office"

  @bogus
  Scenario Outline: Invites must be valid email addresses
    Given I am on the new invitation page for the group "Company Office"
    When I fill in "Email" with "<email>"
    And I press "Invite user"
    Then I should see the form error "not a valid email address" for "Email"
    And "<email>" should not have an invitation for the group "Company Office"

    Scenarios:
      | email         |
      | not-an-email  |
      | something@    |
      | thing@lala    |
      | thing@thing.  |

  Scenario: Group admins can cancel invitations
    Given there is a pending invitation for "user-doesnt-exist@test.com" to join the group "Company Office"
    And I am on the membership page for the group "Company Office"
    When I click on "Cancel invitation"
    Then I should not see "user-doesnt-exist@test.com" within the content area table
    And "user-doesnt-exist@test.com" should not have an invitation for the group "Company Office"
