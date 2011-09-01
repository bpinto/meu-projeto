Feature: View default deal details
  As a guest
  I want to the default deal details
  so I can see their price, company, etc.

    Scenario: Viewing deal's title
      Given 1 deal with title as "MacBook 99% OFF" was registered today
      And I am on today's deals page
      Then I should see "MacBook 99% OFF" within deal's title

    Scenario: Viewing deal's category
      Given 1 deal with category as "Computer" was registered today
      And I am on today's deals page
      Then I should see "Informática" within deal's category

    Scenario: Viewing deal's link
      Given 1 deal with link as "http://www.google.com" was registered today
      And I am on today's deals page
      Then deal should link to "http://www.google.com"

    Scenario: Viewing deal's user
      Given 1 deal from user with name "F_NAME" was registered today
      And I am on today's deals page
      Then I should see "F_NAME" within deal's user
