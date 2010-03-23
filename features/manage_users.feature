Feature: Manage users
  In order to use the application
  As a user
  I want to be able to sign up

  Background:
    Given I am on the new_user page
  
  Scenario Outline: Register new users with valid email
    When I fill in "user_email" with <email>
    And I press "Go"
    Then I should see "Your account has been created"
    And a user should exist with email: <email>
    And I should be on the user's subscriptions page

    Examples:
      | email                        |
      | "user@gmail.com"             |
      | "name.with.period@yahoo.com" |
      | "user+with_tag@gmail.com"    |
      | "rss@user.oib.com"           |


  Scenario Outline: Register new user with invalid email
    When I fill in "user_email" with <email>
    And I press "Go"
    Then I should see "There was a problem creating your account"
    And a user should not exist with email: <email>

    Examples:
      | email                         |
      | ""                            |
      | "notanemail"                  |
      | "email with spaces@gmail.com" |
      | "user@incomplete-url"         |
      | "abc@"                        |
      | "@def.com"                    |
      | "@"                           |


  Scenario: Register a new user with an email that was already registered
    Given a user exists with email: "already.taken@gmail.com"
    When I fill in "user_email" with "already.taken@gmail.com"
    And I press "Go"
    Then I should be on the user's subscriptions page
    And 1 users should exist with email: "already.taken@gmail.com"
