Feature: View active deals
  As a guest
  I want to view active deals
  so I can buy them

    Scenario: Viewing active deals
      Given 2 active deals exists
      And I am on the homepage
      Then I should see 2 deals

    Scenario: Viewing today's deals but not yesterday's
      Given 2 active deals exists
      And 1 inactive deal exist
      And I am on the homepage
      Then I should see 2 deals
