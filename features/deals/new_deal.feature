Feature: New Deal
  As a user 
  I want to register a new deal
  so I can share the deal with others users

    Background:
      Given I am a user with an username "username"

    Scenario: Viewing new deal form
      When I follow "Cadastrar Oferta"
      Then I should be on the new deal page

    Scenario: Creating a new deal successfully
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I press "Compartilhar Oferta"
      Then I should see "Oferta criada com sucesso!"
      And go to the home page

    Scenario: Creating a new deal with errors
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I fill in deal's link with ""
      And I press "Compartilhar Oferta"
      Then I should see "Foram encontrados erros ao criar a oferta."
      And go to the home page

    @wip
    Scenario: Creating a new national deal
      Given I am on the new deal page
      When I fill in the deal fields correctly
      And I choose the deal as national offer
      And I press "Confirm"
      Then I go to the deal's page
      #TODO: verificar que a oferta está como oferta nacional


