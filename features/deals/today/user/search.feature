Feature: New Deal
  As a user
  I want to search for today's deals that belongs to my city range
  so I can browse them easier

    Background:
      Given the city "Rio de Janeiro" exists
      And the city "São Paulo" exists
      And I am a user from "Rio de Janeiro" and "São Paulo"
      And I am on today's deals page

    Scenario: Search should show deals from my city range
      Given 1 deal from "Rio de Janeiro" with title as "Título da Oferta" was registered today
      And 1 deal from "São Paulo" with title as "Título da Oferta" was registered today
      When I fill in the search field with "Oferta"
      And I press "Buscar"
      Then I should see 2 deals

    Scenario: Not viewing active deals that are not within my city range
      Given 1 deal from "Rio de Janeiro" with title as "Título da Oferta" was registered today
      And the city "Outra Cidade" exists
      And 1 deal from "Outra Cidade" with title as "Título da Oferta" was registered today
      When I fill in the search field with "Oferta"
      And I press "Buscar"
      Then I should see 1 deal
