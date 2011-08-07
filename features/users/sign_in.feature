Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an email of "user@test.com"
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Email ou senha inválidos."
      And I go to the home page
      And I should be signed out

    Scenario: User enters wrong password
      Given I am not logged in
      And I am a user named "foo" with an email "user@test.com" and password "please"
      When I go to the sign in page
      And I sign in as "user@test.com/wrongpassword"
      Then I should see "Email ou senha inválidos."
      And I go to the home page
      And I should be signed out

    Scenario: User signs in successfully with email
      Given I am not logged in
      And I am a user named "foo" with an email "user@test.com" and password "please"
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Fez login com sucesso."
      And I should be signed in
      When I return next time
      Then I should be already signed in

    @wip
    Scenario: User signs in successfully with username
      Given I am not logged in
      And I am a user named "foo" with an username "username" and password "please"
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Fez login com sucesso."
      And I should be signed in
      When I return next time
      Then I should be already signed in