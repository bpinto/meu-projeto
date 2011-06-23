Feature: Show Users
  As a registered user of the website
  I want to see my user profile
  so I can see my informations on the site

    Background:
      Given I am a user with an email "test@email.com"

    Scenario: Viewing my deals
      And I have 1 deal
      When I go to test@email.com's page
      Then I should see 1 deal

    Scenario: Viewing my deals but not others'
      And I have 1 deal
      And 1 deal exist
      When I go to test@email.com's page
      Then I should see 1 deal
