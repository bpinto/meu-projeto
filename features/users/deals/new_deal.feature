Feature: New Deal
  As a user 
  I want to register a new deal
  so I can share the deal with others users

    Scenario: Viewing users
      Given I am a user with an email "test@email.com"
      When I go to the home page 
      And follow "Cadastrar Oferta"
      Then I should be on test@email.com's new deal page
