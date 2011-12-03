Feature: New Deal
  As a guest
  I want to search for deals
  so I can browse them easier

    Background:
      Given I am a guest
      And I am on the homepage

    Scenario: Search order box should not change after a search
      When I select search's order with "Maior Desconto"
      And I press "Buscar"
      Then search's order should be selected with "Maior Desconto"
