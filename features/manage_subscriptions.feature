Feature: Manage subscriptions
  In order to read my favorite blogs/feeds
  As a user
  I want to be able to manage subscription and read articles

  Background:
    Given a user exists
    And the user is logged in
    And feed URLs are stubbed
  
  Scenario: Navigating to add a new subscription
    Given I am on the user's subscriptions page
    When I follow "Add a subscription"
    Then I should be on the user's subscription's new page
    
  Scenario Outline: Add new subscription
    Given I am on the user's subscription's new page
    When I fill in "subscription_url" with <url>
    And press "Add"
    Then a subscription should exist with user: the user
    And a feed should exist with url: <url>
    And the feed should be the subscription's feed
    And I should be on the user's subscription's page

    Examples:
      | url                                |
      | "http://www.test-feed-url/rss.xml" |

  Scenario: Unsubscribe from a feed
    Given a subscription exists with user: the user
    And I am on the user's subscription's page
    When I press "Unsubscribe"
    Then a subscription should not exist with user: the user
    And I should be on the user's subscriptions page

  Scenario: Navigate to subscription
    Given a subscription exists with user: the user
    And I am on the user's subscriptions page
    When I follow "Test Feed"
    Then I should be on the user's subscription's page

  Scenario: View articles for subscription
    Given a subscription exists with user: the user
    And I am on the user's subscription's page
    Then I should see "Test Feed"
    And I should see "Entry 1"
    And I should see "Test User"
    And I should see "Content goes here"