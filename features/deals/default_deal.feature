Feature: View default deal details
  As a guest
  I want to the default deal details
  so I can see their price, company, etc.

    Scenario: Viewing deal's title
      Given 1 deal with title as "MacBook 99% OFF" was registered today
      And I am on today's deals page
      Then I should see "MacBook 99% OFF" within deal's title

    Scenario: Viewing deal's address
      Given 1 deal with address as "Shopping Mall" was registered today
      And I am on today's deals page
      Then I should see "Shopping Mall" within deal's address

    Scenario: Viewing deal's real price
      Given 1 deal with real_price as "1020.01" was registered today
      And I am on today's deals page
      Then I should see "R$ 1.020,01" within deal's real_price

    Scenario: Viewing deal's price
      Given 1 deal with price as "190.99" was registered today
      And I am on today's deals page
      Then I should see "R$ 190,99" within deal's price
