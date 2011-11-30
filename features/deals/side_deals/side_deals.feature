Feature: Side Deals
  As a guest
  I want to see the small deals ordered
  so I can browse them easier

    Background:
      Given I am a guest
    
    Scenario: I should see the 3 most recent offers
      Given 1 deal with title as "Primeira" was registered today
      Given 1 deal with title as "Segunda" was registered today
      Given 1 deal with title as "Terceira" was registered today
      Given 1 deal with title as "Quarta" was registered today
      And I am on active's deals page
      Then I should see 1 side deal with title "Quarta" in newest list
      Then I should see 1 side deal with title "Terceira" in newest list
      Then I should see 1 side deal with title "Segunda" in newest list
    
    Scenario: I should see the 3 most commented offers
      Given 1 deal with title as "Primeira" was registered today with 3 comments
      Given 1 deal with title as "Segunda" was registered today with 2 comments
      Given 1 deal with title as "Terceira" was registered today with 5 comments
      Given 1 deal with title as "Quarta" was registered today with 1 comments
      And I am on active's deals page
      Then I should see 1 side deal with title "Terceira" in most_commented list
      Then I should see 1 side deal with title "Primeira" in most_commented list
      Then I should see 1 side deal with title "Segunda" in most_commented list

    Scenario: I should see the 3 best deals
      Given 1 deal with title as "Primeira" was registered today with 1 up vote and 0 down vote
      Given 1 deal with title as "Segunda" was registered today with 1 up vote and 1 down vote
      Given 1 deal with title as "Terceira" was registered today with 1 up vote and 3 down votes
      Given 1 deal with title as "Quarta" was registered today with 0 up vote and 1 down vote
      And I am on active's deals page
      Then I should see 1 side deal with title "Primeira" in best list
      Then I should see 1 side deal with title "Segunda" in best list
      Then I should see 1 side deal with title "Terceira" in best list
