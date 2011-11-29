Feature: View today's deals
  As a user
  I want to view today's deals that belongs to my city range
  so I can buy them

    Background:
      Given the city "Rio de Janeiro" exists
      And the city "São Paulo" exists
      And I am a user from "Rio de Janeiro" and "São Paulo"

    Scenario: Viewing today's deals from my city
      Given 2 deals from "Rio de Janeiro" were registered today
      And I am on today's deals page
      Then I should see 2 deals

    Scenario: Not viewing yesterday's deals from my city
      Given 2 deals from "Rio de Janeiro" were registered today
      And 1 deal from "Rio de Janeiro" were registered yesterday
      And I am on today's deals page
      Then I should see 2 deals

    Scenario: Viewing today's deals within my city range
      Given 1 deal from "Rio de Janeiro" was registered today
      And 1 deal from "São Paulo" was registered today
      And 1 deal from "São Paulo" was registered yesterday
      And I am on today's deals page
      Then I should see 2 deals

    Scenario: Not viewing today's deals that are not within my city range
      Given 1 deal from "Rio de Janeiro" was registered today
      And the city "Outra Cidade" exists
      And 1 deal from "Outra Cidade" was registered today
      And I am on today's deals page
      Then I should see 1 deal
