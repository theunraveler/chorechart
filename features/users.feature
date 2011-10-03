Feature: Users
  In order to keep track of my chores
  As an anomymous user
  I want to create and manage my account

  Scenario: Creating an account
    Given I do not have a user account already
    When I go to the user registration page
    And I enter "test_user", "test@test.com", and "password" as my username, email, and password
    Then I should be taken to the home page
    And I should see the flash message "Thanks for signing up! You will receive an email shortly to confirm your account."

  Scenario: Logging in
    Given I have a user account with username "test" and password "password"
    When I go to the login page
    And I enter my credentials
    Then I should be taken to my user page
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
    And I should see "Register" within the header
    And I should see "Log in" within the header

  Scenario: Deleting account
    Given I am logged in as "testuser"
    When I click on "Your Account"
    And I click on "Delete my account"
    Then I should be taken to the home page
    And my account should be deleted
