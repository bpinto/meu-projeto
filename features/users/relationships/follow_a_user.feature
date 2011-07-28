Feature: Follow a user
  As a user 
  I want to follow another user
  So I can follow his deals

    Background:
      Given one user with an email "user_to_follow@email.com" exists
      And I am a user with an email "myself@email.com"

    Scenario: Follow a unfollowed user
      Given I am on user_to_follow@email.com's page
      When I follow "Follow"
      Then I should see "Started following: 'user_to_follow@email.com'"

    Scenario: Follow a user already followed
      Given I am following the user "user_to_follow@email.com"
      And I am on user_to_follow@email.com's page
      Then I should not see "Follow"

    Scenario: Follow a user already followed - by url
      Given I am following the user "user_to_follow@email.com"
      And I go to user_to_follow@email.com's follow page
      Then I should see "You already follow: 'user_to_follow@email.com'"
