@omniauth
Feature: Allow users to log in and register for the site using other services
  In order to easily register for and log in to the site
  As a user
  I want to be able to register and log in to the site using other services

  Scenario: Existing users can add a Facebook account to their account
    Given I am logged in as "test_user"
    And I have no authentications
    And I am on my authentications page
    When I click on "Facebook"
    Then I should see the flash message "Authentication successfully added."
    And I should see "Facebook" within my authentications
    And I should not see an image with alt text "Facebook" within the available services
    And I should have 1 authentication

  Scenario: Existing users can log in with an existing Facebook authentication
    Given I have a user account with username "test_user" and password "password"
    And I have attached my Facebook account
    And I am on the login page
    When I click on "Facebook"
    Then I should see the flash message "Logged in successfully. Welcome."
    And I should be on the dashboard
    And I should see my username within the header
    
  Scenario: Users can delete an existing authentication
    Given I am logged in as "test_user"
    And I have attached my Facebook account
    And I am on my authentications page
    When I delete my Facebook account
    Then I should be on my authentications page
    And I should see the flash message "Authentication successfully removed."
    And I should have 0 authentications
    And I should see an image with alt text "Facebook" within the available services

  Scenario: Creating an account with a service where everything is provided
    Given I do not have a user account already
    And I am on the user registration page
    When I click on "Facebook"
    Then I should see the flash message "An account has been created for you"
    And I should be on the dashboard
    And I should see "Hello, Facebook" within the header

