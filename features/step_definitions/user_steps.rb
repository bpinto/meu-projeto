Given /^no user exists with an (?:username|email) of "(.*)"$/ do |login|
  User.find_record(login).should be_nil
end

Given /^one user with an (email|username) "([^"]*)" exists$/ do |property, value|
  FactoryGirl.create :confirmed_user, property => value
end

Given /^one user with an (email|username) "([^"]*)" exists and I follow him$/ do |property, value|
  user = FactoryGirl.create :confirmed_user, property => value
  @current_user.follow!(user)
end

Given /^I am a guest$/ do
  visit('/users/sign_out')
end

Given /^I am a user from "([^"]*)" and "([^"]*)"$/ do |city, another_city|
  @current_user = FactoryGirl.create :confirmed_user
  @current_user.cities << City.find_by_name(city)
  @current_user.cities << City.find_by_name(another_city)
end

Given /^I am a user with an (email|username) "([^"]*)"$/ do |property, value|
  @current_user = FactoryGirl.create :confirmed_user, property => value

  And %{I go to the sign in page}
  And %{I fill in "user_login" with "#{@current_user.email}"}
  And %{I fill in "user_password" with "#{@current_user.password}"}
  And %{I press "Sign in"}
end

Given /^I am a user with an (email|username) "([^"]*)" and password "([^"]*)"$/ do |property, value, password|
  @current_user = FactoryGirl.create :confirmed_user, property => value, :password => password, :password_confirmation => password
end

Then /^I should be already signed in$/ do
  And %{I should see "Sair"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{password}"}
  And %{I press "Cadastre-se"}
  Then %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  And %{I am logout}
end

When /^I sign in as "(.*)\/(.*)"$/ do |login, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in user's login with "#{login}"}
  And %{I fill in user's password with "#{password}"}
  And %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Fez login com sucesso."}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Crie seu perfil"}
  And %{I should see "Entrar"}
  And %{I should not see "Sair"}
end

Given /^I am not logged in$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I follow a user with (email|username) "([^"]*)" who has (\d+) deal$/ do |property, value, amount|
  user = FactoryGirl.create :confirmed_user, property => value
  @current_user.follow!(user)
  FactoryGirl.create :deal, :user => user
end

Then /^I should see a link to edit my information on "([^"].*)"$/ do |page_name|
  page.find(:xpath, "//div[@class='titulo']//a")[:href].should == path_to(page_name)
end

Then /^I should see a link to "([^"].*)"$/ do |page_name|
  page.find(:xpath, "//ul[@class='interacoes']//a")[:href].should == path_to(page_name)
end
