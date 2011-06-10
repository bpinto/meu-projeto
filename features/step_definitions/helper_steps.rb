Then /^stop/ do
  debugger
  1
end

Then /^(.*) should be selected with "(.*)"$/ do |field, text|
  find_field(field).all(:css, "option[@selected]").first.text.should == text
end

When /^(.*) (on (?:.*)'s line)$/ do |step, campo|
  with_scope(campo) { Quando step }
end

Then /^a (.*) (?:do|da|de) (.*) deve estar selecionada com a data de hoje$/ do |nome_do_campo, nome_da_classe|
  campo = pegar_campo(nome_da_classe, nome_do_campo)

  hoje = Date.today
  field_labeled("#{campo}_3i").value.should == hoje.day.to_s
  field_labeled("#{campo}_2i").value.should == hoje.month.to_s
  field_labeled("#{campo}_1i").value.should == hoje.year.to_s
end

When /^eu preencho o (.*) (?:do|da|de) (.*) com "(.*)"$/ do |nome_do_campo, nome_da_classe, valor|
  campo = pegar_campo(nome_da_classe, nome_do_campo)
  fill_in(campo, :with => valor)
end

When /^eu seleciono o (.*) (?:do|da|de) (.*) com "(.*)"$/ do |nome_do_campo, nome_da_classe, valor|
  campo = pegar_campo(nome_da_classe, nome_do_campo)
  select(valor, :from => campo)
end

When /^eu escolho o (.*) como (.*)$/ do |nome_da_classe, nome_do_campo|
  campo = pegar_campo(nome_da_classe, nome_do_campo)
  choose(campo)
end

When /^o (.*) (?:do|da|de) (.*) deve ser "(.*)"$/ do |nome_do_campo, nome_da_classe, valor|
  campo = pegar_campo(nome_da_classe, nome_do_campo)
  find_field(campo).value.should == valor
end
