Feature: Unfollow a user
  As a user with followed users
  I want to unfollow another user
  So I can unfollow his deals

    Background:
      Given one user with an email "user_to_unfollow@email.com" exists
      And I am a user with an email "myself@email.com"

    Scenario: Unfollow a followed userr
      Given I am following the user "user_to_unfollow@email.com"
      And I am on user_to_unfollow@email.com's page
      When I follow "Unfollow"
      Then I should see "Stopped following: 'user_to_unfollow@email.com'"

    Scenario: Unfollow a user already unfollowed
      Given I am not following the user "user_to_unfollow@email.com"
      And I am on user_to_unfollow@email.com's page
      Then I should not see "Unfollow"

    Scenario: Unfollow a user already unfollowed - by url
      Given I am not following the user "user_to_unfollow@email.com"
      And I go to user_to_unfollow@email.com's unfollow page
      Then I should see "You do not follow: 'user_to_unfollow@email.com'"
