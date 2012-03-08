Feature: New Deal
  As a user 
  I want to register a new deal
  so I can share the deal with others users

    Background:
      Given I am a user with an username "username"
      And the city "Rio de Janeiro" exists

    Scenario: Viewing new deal form
      When I follow "Cadastrar uma Oferta"
      Then I should be on the new deal page

    Scenario: Creating a new deal successfully
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I press "Compartilhar" within the new deal form
      Then I should see "Oferta criada com sucesso!"
      And go to the home page

    Scenario: Creating a new deal with errors
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I fill in deal's link with ""
      And I press "Compartilhar" within the new deal form
      Then I should see "Foram encontrados erros ao criar a oferta."
      And go to the home page

    Scenario: Creating a deal already created
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I fill in deal's link with "http://www"
      And I press "Compartilhar" within the new deal form
      And I am on the new deal page
      And I fill in the deal fields correctly
      And I fill in deal's link with "http://www"
      And I press "Compartilhar" within the new deal form
      Then I should see "A oferta abaixo já foi compartilhada por outro usuário"