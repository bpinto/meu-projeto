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

    Scenario: Going to deal's page follow 'Saiba mais' button
      Given 1 deal with title as "my deal" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"
      Then I should be on deal "my deal"'s page

    Scenario: Going to deal's page follow deal's title
      Given 1 deal with title as "my deal" was registered today
      And I am on today's deals page
      When I follow "my deal"
      Then I should be on deal "my deal"'s page

    Scenario: Viewing deal's user
      Given 1 deal from user with name "F_NAME" was registered today
      And I am on today's deals page
      Then I should see "F_NAME" within deal's user
