Feature: Search Users
  In order to find friends in the system
  A user
  Should be able search for others users

  Scenario: Viewing the Follow link on another user page
    Given I am a user with an username "my_user"
    And one user with an username "unfollow_user" exists
    When I go to users page
    Then I should see a link to "unfollow_user's follow page"

  Scenario: Viewing the Unfollow link on another use page
    Given I am a user with an username "my_user"
    And one user with an username "followed_user" exists and I follow him
    When I go to users page
    Then I should see a link to "followed_user's unfollow page"

  Scenario: Viewing user's name
    Given one user with a name "name" exists
    And I am on users page
    Then I should see "name" within user's name

  Scenario: Viewing user's username
    Given one user with an username "username" exists
    And I am on users page
    Then I should see "username" within user's username

  Scenario: Viewing link to user's profile
    Given one user with an username "username" exists
    And I am on users page
    Then I should see a profile link to "username's page"

  Scenario: Search without results should show a no users found message
    When I fill in the users search field with "Usuario Inexistente"
    And I press "Buscar"
    Then I should see "Não foi encontrado nenhum usuário"

  Scenario: Search with results should not show a no deals found message
    Given one user with a name "name" exists
    When I fill in the users search field with "name"
    And I press "Buscar"
    Then I should not see "Não foi encontrado nenhum usuário"