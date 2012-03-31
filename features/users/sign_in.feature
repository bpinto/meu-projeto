Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Background:
      Given the city "Rio de Janeiro" exists

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an email of "user_not_signed_up@email.com"
      When I sign in as "user_not_signed_up@email.com/password"
      Then I should see "Dados inválidos."
      And I should be signed out

    Scenario: User enters wrong password
      Given I am not logged in
      And I am a user with an email "user@email.com" and password "password"
      When I sign in as "user@email.com/wrongpassword"
      Then I should see "Dados inválidos."
      And I should be signed out

    Scenario: User signs in successfully with email
      Given I am not logged in
      And I am a user with an email "user@email.com" and password "password"
      When I sign in as "user@email.com/password"
      Then I should see "Fez login com sucesso."
      And I should be signed in
      When I return next time
      Then I should be already signed in

    Scenario: User signs in successfully with username
      Given I am not logged in
      And I am a user with an username "username" and password "password"
      When I sign in as "username/password"
      Then I should see "Fez login com sucesso."
      And I should be signed in
      When I return next time
      Then I should be already signed in
