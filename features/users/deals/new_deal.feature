Feature: New Deal
  As a user 
  I want to register a new deal
  so I can share the deal with others users

    Scenario: Viewing users
      Given I am a user with an email "test@email.com" and a password "teste123"
      When I sign in as "test@email.com/teste123"
      And follow "Cadastrar Oferta"
      Then I should be on test@email.com's new deal page
