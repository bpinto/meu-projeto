Feature: Search Deal as Guest
  As a guest
  I want to search for active deals
  so I can browse them easier

    Background:
      Given I am a guest
      And I am on active's deals page

    Scenario: Search result page should remain active deals page
      When I press "Buscar"
      Then I should be on active's deals page

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

    Scenario: Search ordered by most recent
      Given 1 deal with title as "Primeira Oferta" was registered today
      Given 1 deal with title as "Segunda Oferta" was registered today
      When I select search's order with "Mais Recente"
      And I press "Buscar"
      Then I should see "Segunda Oferta" before "Primeira Oferta"

    Scenario: Search ordered by lowest price
      Given 1 deal with price as "1.99" was registered today
      Given 1 deal with price as "3.99" was registered today
      Given 1 deal with price as "6.99" was registered today
      When I select search's order with "Menor Preço"
      And I press "Buscar"
      Then I should see "1,99" before "3,99"
      And I should see "3,99" before "6,99"

    Scenario: Search ordered by highest price
      Given 1 deal with price as "1.99" was registered today
      Given 1 deal with price as "3.99" was registered today
      Given 1 deal with price as "6.99" was registered today
      When I select search's order with "Maior Preço"
      And I press "Buscar"
      Then I should see "6,99" before "3,99"
      And I should see "3,99" before "1,99"

    Scenario: Search ordered by highest discount
      Given 1 deal with discount as "20" was registered today
      Given 1 deal with discount as "40" was registered today
      Given 1 deal with discount as "30" was registered today
      When I select search's order with "Maior Desconto"
      And I press "Buscar"
      Then I should see "40" before "30"
      And I should see "30" before "20"
