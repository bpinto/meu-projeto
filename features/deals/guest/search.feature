Feature: New Deal
  As a guest
  I want to search for active deals
  so I can browse them easier

    Background:
      Given I am a guest

    Scenario: Search without results should show a no deals found message
      When I fill in the search field with "Oferta não existente"
      And I press "Buscar"
      Then I should see "Não foi encontrada nenhuma oferta com 'Oferta não existente'"

    Scenario: Search with results should not show a no deals found message
      Given 1 deal with title as "Título da Oferta" was registered today
      When I fill in the search field with "Título da Oferta"
      And I press "Buscar"
      Then I should not see "Não foi encontrada nenhuma oferta"

    Scenario: Search with one result
      Given 1 deal with title as "Título da Oferta" was registered today
      When I fill in the search field with "Título da Oferta"
      And I press "Buscar"
      Then I should see 1 deal with title "Título da Oferta"

    Scenario: Search with more than one result
      Given 3 deals with title as "Título da Oferta" was registered today
      When I fill in the search field with "Título da Oferta"
      And I press "Buscar"
      Then I should see 3 deals with title "Título da Oferta"

    Scenario: Search should ignore case
      Given 1 deal with title as "Título da Oferta" was registered today
      When I fill in the search field with "título da oferta"
      And I press "Buscar"
      Then I should see 1 deal with title "Título da Oferta"

    Scenario: Search by a part of the title
      Given 1 deal with title as "Título da Oferta" was registered today
      When I fill in the search field with "Oferta"
      And I press "Buscar"
      Then I should see 1 deal with title "Título da Oferta"

    Scenario: Search by a part of the description
      Given 1 deal with description as "Descrição da Oferta" was registered today
      When I fill in the search field with "Oferta"
      And I press "Buscar"
      Then I should see 1 deal

    Scenario: Search should show deals from all cities
      Given the city "Rio de Janeiro" exists
      And the city "São Paulo" exists
      And 1 active deal from "Rio de Janeiro" with title as "Título da Oferta" exists
      And 1 active deal from "São Paulo" with title as "Título da Oferta" exists
      When I fill in the search field with "Oferta"
      And I press "Buscar"
      Then I should see 2 deals