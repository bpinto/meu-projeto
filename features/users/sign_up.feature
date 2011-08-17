Feature: Criar perfil
  In order to get access to protected sections of the site
  A user
  Should be able to sign up

    Scenario: User signs up with valid data
      Given I am not logged in
      When I go to the sign up page
      And I fill in user's name with "user"
      And I fill in user's email with "user@test.com"
      And I fill in user's username with "username"
      And I fill in user's password with "please"
      And I fill in user's password confirmation with "please"
      And I press "Criar perfil"
      Then I should see "A sua conta foi criada com sucesso. No entanto, não foi possível fazer login, pois ela está unconfirmed."

    Scenario: User signs up with invalid email
      Given I am not logged in
      When I go to the sign up page
      And I fill in user's email with "invalidemail"
      And I fill in user's password with "please"
      And I fill in user's password confirmation with "please"
      And I press "Criar perfil"
      Then I should see "Email não é válido"

    Scenario: User signs up without password
      Given I am not logged in
      When I go to the sign up page
      And I fill in user's email with "user@test.com"
      And I fill in user's password with ""
      And I fill in user's password confirmation with "please"
      And I press "Criar perfil"
      Then I should see "Senha não pode ficar em branco"

    Scenario: User signs up without password confirmation
      Given I am not logged in
      When I go to the sign up page
      And I fill in user's email with "user@test.com"
      And I fill in user's password with "please"
      And I fill in user's password confirmation with ""
      And I press "Criar perfil"
      Then I should see "Senha não está de acordo com a confirmação"

    Scenario: User signs up with password and password confirmation that doesn't match
      Given I am not logged in
      When I go to the sign up page
      And I fill in user's email with "user@test.com"
      And I fill in user's password with "please"
      And I fill in user's password confirmation with "please1"
      And I press "Criar perfil"
      Then I should see "Senha não está de acordo com a confirmação"
