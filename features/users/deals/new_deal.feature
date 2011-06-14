Feature: New Deal
  As a user 
  I want to register a new deal
  so I can share the deal with others users

    Background:
      Given I am a user with an email "test@email.com" and a password "teste123"
      When I sign in as "test@email.com/teste123"

    Scenario: Viewing new deal form
      When I follow "Cadastrar Oferta"
      Then I should be on test@email.com's new deal page

    Scenario: Saving new deal form
      Given I am on test@email.com's new deal page
      When I fill the deal fields correctly
      And I press "Confirm"
      Then I should see "Deal created with success!"
      And go to the home page

