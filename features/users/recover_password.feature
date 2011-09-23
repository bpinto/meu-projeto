Feature: Recover password
  In order to login when the password was lost
  A user
  Should be able to recover his password by receiving an e-mail

    Scenario: E-mail not filled
      Given I am not logged in
      And I am on recover email page
      And I press "Enviar nova senha"
      Then I should see "Email não pode ficar em branco"

    Scenario: E-mail not registered
      Given I am not logged in
      And no user exists with an email of "not_registered@email.com"
      And I am on recover email page
      When I fill in user's email with "not_registered@email.com"
      And I press "Enviar nova senha"
      Then I should see "Email não encontrado"

    Scenario: E-mail registered
      Given I am not logged in
      And one user with an email "registered@email.com" exists
      And I am on recover email page
      When I fill in user's email with "registered@email.com"
      And I press "Enviar nova senha"
      Then I should see "Dentro de minutos, receberá um email com as instruções de reinicialização da senha."
