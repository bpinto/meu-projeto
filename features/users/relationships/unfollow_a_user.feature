Feature: Unfollow a user
  As a user with followed users
  I want to unfollow another user
  So I can unfollow his deals

    Background:
      Given the city "Rio de Janeiro" exists
      Given one user with an username "user_to_unfollow" exists
      And I am a user with an username "myself"

    Scenario: Unfollow a followed userr
      Given I am following the user "user_to_unfollow"
      And I am on user_to_unfollow's page
      When I follow "Deixar de seguir"
      Then I should see "Deixando de seguir: 'user_to_unfollow'!"

    Scenario: Unfollow a user already unfollowed
      Given I am not following the user "user_to_unfollow"
      And I am on user_to_unfollow's page
      Then I should not see "Deixar de seguir"

    Scenario: Unfollow a user already unfollowed - by url
      Given I am not following the user "user_to_unfollow"
      And I go to user_to_unfollow's unfollow page
      Then I should see "Você não está seguindo: 'user_to_unfollow'!"
