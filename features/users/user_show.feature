Feature: Show Users
  As a registered user of the website
  I want to see my user profile
  so I can see my informations on the site

    Background:
      Given I am a user with an username "my_user"

    Scenario: Viewing my deals
      Given I have 1 deal
      When I go to my_user's page
      Then I should see 1 deal

    Scenario: Viewing my deals but not others
      Given I have 1 deal
      And 1 other deal exist
      When I go to my_user's page
      Then I should see 1 deal

    Scenario: Viewing deals from me and users I follow
      Given I have 1 deal
      And I follow a user with username "user_with_1_deal" who has 1 deal
      When I go to my_user's page
      Then I should see 2 deals

    Scenario: Viewing link to edit in my user's page
      Given I am on my_user's page
      Then I should see a link to edit my information on "my_user's edit page"

    Scenario: Viewing the Follow link on another user page
      Given one user with an username "unfollow_user" exists
      When I go to unfollow_user's page
      Then I should see a link to "unfollow_user's follow page"

    Scenario: Viewing the Unfollow link on another use page
      Given one user with an username "followed_user" exists and I follow him
      When I go to followed_user's page
      Then I should see a link to "followed_user's unfollow page"

    @wip
    Scenario: Not viewing the follow link on my user page
      Given I am on my_user's page
      Then I should not see a link to "follow_user" path

    @wip
    Scenario: Not viewing the unfollow link on my user page
      Given I am on my_user's page
      Then I should not see a link to "unfollow_user" path
