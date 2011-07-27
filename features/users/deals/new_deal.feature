Feature: New Deal
  As a user 
  I want to register a new deal
  so I can share the deal with others users

    Background:
      Given I am a user with an email "test@email.com"

    Scenario: Viewing new deal form
      When I follow "Cadastrar Oferta"
      Then I should be on test@email.com's new deal page

    Scenario: Creating a new deal successfully
      Given I am on test@email.com's new deal page
      When I fill the deal fields correctly
      And I press "Confirm"
      Then I should see "Oferta criada com sucesso!"
      And go to the home page

    Scenario: Creating a new deal with errors
      Given I am on test@email.com's new deal page
      When I fill the deal fields correctly
      And I fill deal's link with ""
      And I press "Confirm"
      Then I should see "Foram encontrados erros ao criar a oferta."
      And go to the home page
