Feature: New Deal
  As a guest
  I want to search for active deals
  so I can browse them easier

    Background:
      Given I am a guest

    Scenario: Search without result
      When I fill in the search field with "Oferta não existente"
      And I press "Buscar"
      Then I should see "Não foi encontrada nenhuma oferta com 'Oferta não existente'"

    @wip
    Scenario: Search with one result
      Given 1 deal with title as "Título da Oferta" was registered today
      When I fill in the search field with "Nome da Oferta"
      And I press "Buscar"
      Then I should see one deal with title "Título da Oferta"
      But I should not see "Não foi encontrada nenhuma oferta"

    @wip
    Scenario: Search with more than one result
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I fill in deal's link with ""
      And I press "Compartilhar Oferta"
      Then I should see "Foram encontrados erros ao criar a oferta."
      And go to the home page
