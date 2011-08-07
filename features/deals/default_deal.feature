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

    @todo_i18n
    Scenario: Viewing deal's category
      Given 1 deal with category as "Computer" was registered today
      And I am on today's deals page
      Then I should see "Informática" within deal's category

#    @todo_i18n
#    Scenario: Viewing deal's kind
#      Given 1 deal with kind as "daily_deal" was registered today
#      And I am on today's deals page
#      Then I should see "Compras Coletivas" within deal's kind

    Scenario: Viewing deal's link
      Given 1 deal with link as "http://www.google.com" was registered today
      And I am on today's deals page
      Then deal should link to "http://www.google.com"