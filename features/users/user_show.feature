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

    Scenario: Viewing my deals but not others'
      Given I have 1 deal
      And 1 other deal exist
      When I go to my_user's page
      Then I should see 1 deal
