Then /^stop$/ do
  binding.pry
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |first, last|
  page.find(:xpath, "//*[contains(text(), '#{first}')]/following::*[contains(text(), '#{last}')]")
end

Then /^(.*)'s (.*) should be selected with "(.*)"$/ do |klass_name, field_name, value|
  field = get_field(klass_name, field_name)
  find_field(field).all(:css, "option[@selected]").first.text.should == value
end

When /^(.*) (na linha do .*)$/ do |step, campo|
  with_scope(campo) { Quando step }
end

Then /^a (.*) (?:do|da|de) (.*) deve estar selecionada com a data de hoje$/ do |nome_do_campo, nome_da_classe|
  campo = pegar_campo(nome_da_classe, nome_do_campo)

  hoje = Date.today
  field_labeled("#{campo}_3i").value.should == hoje.day.to_s
  field_labeled("#{campo}_2i").value.should == hoje.month.to_s
  field_labeled("#{campo}_1i").value.should == hoje.year.to_s
end

When /^I fill in (.*)'s (.*) with "(.*)"$/ do |klass_name, field_name, value|
  field = get_field(klass_name, field_name)
  fill_in(field, :with => value)
end

When /^I select (.*)'s (.*) with "(.*)"$/ do |klass_name, field_name, value|
  field = get_field(klass_name, field_name)
  select(value, :from => field)
end

When /^eu escolho o (.*) como (.*)$/ do |nome_da_classe, nome_do_campo|
  campo = pegar_campo(nome_da_classe, nome_do_campo)
  choose(campo)
end

Then /^o (.*) (?:do|da|de) (.*) deve ser "(.*)"$/ do |nome_do_campo, nome_da_classe, valor|
  campo = pegar_campo(nome_da_classe, nome_do_campo)
  find_field(campo).value.should == valor
end
