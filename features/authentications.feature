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
    And I should not see "Facebook" within the available services
    And I should have 1 authentication

  Scenario: Existing users can log in with an existing Facebook authentication
    Given I have a user account with username "test_user" and password "password"
    And I have attached my Facebook account
    And I am on the login page
    When I click on "Facebook"
    Then I should see the flash message "Logged in successfully. Welcome."
    And I should be on the dashboard
    And I should see my username within the header
    
