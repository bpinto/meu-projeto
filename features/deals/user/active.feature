Feature: View active deals
  As a user
  I want to view active deals that belongs to my city range
  so I can buy them

    Background:
      Given the city "Rio de Janeiro" exists
      And the city "São Paulo" exists
      And I am a user from "Rio de Janeiro" and "São Paulo"

    Scenario: Viewing active deals from my city
      Given 2 active deals from "Rio de Janeiro" exists
      And I am on the homepage
      Then I should see 2 deals

    Scenario: Not viewing inactive deals from my city
      Given 2 active deals from "Rio de Janeiro" exists
      And 1 inactive deal exist
      And I am on the homepage
      Then I should see 2 deals

    Scenario: Viewing active deals within my city range
      Given 1 active deal from "Rio de Janeiro" exist
      And 1 active deal from "São Paulo" exist
      And 1 inactive deal exist
      And I am on the homepage
      Then I should see 2 deals

    Scenario: Not viewing active deals that are not within my city range
      Given 1 active deal from "Rio de Janeiro" exist
      And the city "Outra Cidade" exists
      And 1 active deal from "Outra Cidade" exist
      And I am on the homepage
      Then I should see 1 deal
