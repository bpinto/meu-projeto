Feature: Sign up
  In order to get access to protected sections of the site
  A user
  Should be able to sign up

    Scenario: User signs up with valid data
      Given I am not logged in
      When I go to the sign up page
      And I fill in "Email" with "user@test.com"
      And I fill in "Password" with "please"
      And I fill in "Password confirmation" with "please"
      And I press "Sign up"
      Then I should see "A sua conta foi criada com sucesso. No entanto, não foi possível fazer login, pois ela está unconfirmed."

    Scenario: User signs up with invalid email
      Given I am not logged in
      When I go to the sign up page
      And I fill in "Email" with "invalidemail"
      And I fill in "Password" with "please"
      And I fill in "Password confirmation" with "please"
      And I press "Sign up"
      Then I should see "Email não é válido"

    Scenario: User signs up without password
      Given I am not logged in
      When I go to the sign up page
      And I fill in "Email" with "user@test.com"
      And I fill in "Password" with ""
      And I fill in "Password confirmation" with "please"
      And I press "Sign up"
      Then I should see "Password não pode ficar em branco"

    Scenario: User signs up without password confirmation
      Given I am not logged in
      When I go to the sign up page
      And I fill in "Email" with "user@test.com"
      And I fill in "Password" with "please"
      And I fill in "Password confirmation" with ""
      And I press "Sign up"
      Then I should see "Password não está de acordo com a confirmação"

    Scenario: User signs up with password and password confirmation that doesn't match
      Given I am not logged in
      When I go to the sign up page
      And I fill in "Email" with "user@test.com"
      And I fill in "Password" with "please"
      And I fill in "Password confirmation" with "please1"
      And I press "Sign up"
      Then I should see "Password não está de acordo com a confirmação"
