Feature: View default deal details
  As a guest
  I want to see the deal's page
  so I can see their price, company, comments, etc.

    Scenario: Viewing deal's title
      Given 1 deal with title as "my deal" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"
      Then I should see "my deal" within deal's title

    Scenario: Viewing deal's category
      Given 1 deal with category as "Computer" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"
      Then I should see "Informática" within deal's category
  
    Scenario: Viewing deal's price
      Given 1 deal with price_mask as "1,20" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"
      Then I should see "R$1,20" within deal's price

    Scenario: Viewing deal's real price
      Given 1 deal with real_price_mask as "1,20" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"
      Then I should see "R$1,20" within deal's real_price

    Scenario: Viewing deal's discount
      Given 1 on sale deal with discount as "30" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"
      Then I should see "30" within deal's discount            
