Feature: Users
  In order to keep track of my chores
  As an anomymous user
  I want to create and manage my account

  Scenario: Creating an account
    Given I do not have a user account already
    When I go to the user registration page
    And I enter "test_user", "test@test.com", and "password" as my username, email, and password
    Then I should be taken to the dashboard
    And I should see the flash message "Thanks for signing up!"

  Scenario: Creating an account with no password
    Given I do not have a user account already
    When I go to the user registration page
    And I enter "test_user", "test@test.com", and "" as my username, email, and password
    And I should see the flash message "Password can't be blank"

  Scenario: Logging in
    Given I have a user account with username "test" and password "password"
    When I go to the login page
    And I enter my credentials
    Then I should be taken to the dashboard
    And I should see "Hello, test"
    And I should see the flash message "Logged in successfully. Welcome."
    And I should see my username within the header

  Scenario: Avatar
    Given I am logged in as "testuser"
    Then I should see my avatar within the header

  Scenario: Logging out
    Given I am logged in as "testuser"
    When I click on "Log out"
    Then I should be taken to the home page
    And I should see the flash message "Logged out successfully. See you next time."
    And I should not see my username within the header
    And I should see "Log in" within the header

  Scenario: Editing my profile
    Given I am logged in as "testuser"
    When I click on "Edit Account" within the header
    And I fill in "Name" with "John Doe"
    And I press "Update"
    Then I should be on the dashboard
    And I should see the flash message "Account details updated."

  @bogus
  Scenario: Editing my profile with bogus data
    Given I am logged in as "testuser"
    When I click on "Edit Account" within the header
    And I fill in "Email" with ""
    And I press "Update"
    Then I should see the flash message "Email can't be blank"

  Scenario: Deleting account
    Given I am logged in as "testuser"
    When I click on "Account"
    And I click on "Delete my account"
    Then I should be taken to the home page
    And my account should be deleted

  Scenario: Going to the dashboard
    Given I am logged in as "testuser"
    When I click on "Chorechart" within the header
    Then I should be on the dashboard
