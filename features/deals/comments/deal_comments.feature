Feature: Adding deal's comments
  As a user
  I want to add a comment to a deal
  So I can express my opinion

    Background:
      Given I am a user
      And 1 deal with title as "my deal" was registered today
      And I am on today's deals page
      When I follow "Saiba mais"

    Scenario: Adding a comment
      Given I fill in comment's comment with "exemplo"
      And I press "Comentar"
      Then I should see 1 comment