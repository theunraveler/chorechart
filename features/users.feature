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
    And I should see "Welcome, test"
    And I should see the flash message "Signed in successfully."
