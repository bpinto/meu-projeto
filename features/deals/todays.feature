Feature: View today's deals
  As a guest
  I want to view today's deals
  so I can buy them

    Scenario: Going to today's deals page
      Given I am on the home page
      When I follow "Ofertas do Dia"
      Then I should be on today's deals page

    Scenario: Viewing today's deals
      Given 2 deals were registered today
      And I am on today's deals page
      Then I should see 2 deals

    Scenario: Viewing today's deals but not yesterday's
      Given 2 deals were registered today
      And 1 deal was registered yesterday
      And I am on today's deals page
      Then I should see 2 deals
