#coding: UTF-8

Given /^(\d+)(?:| other) deals? exists?$/i do |amount|
  amount.to_i.times do
    FactoryGirl.create :deal
  end
end

Given /^(\d+) (active|inactive) deals? exists?$/i do |amount, status|
  amount.to_i.times do
    deal = FactoryGirl.build "#{status}_deal"
    deal.save!(:validate => false) #Uma oferta inativa é inválida
  end
end

Given /^(\d+) (active|inactive) deals? from "([^"]*)" exists?$/i do |amount, status, city|
  amount.to_i.times do
    deal = FactoryGirl.build "#{status}_deal", :city => City.find_by_name(city)
    deal.save!(:validate => false) #Uma oferta inativa é inválida
  end
end

Given /^(\d+) (active|inactive) deals? from "([^"]*)" with ([\w ]+) as "([^"]*)" exists?$/ do |amount, status, city, attribute, value|
  attribute = attribute.gsub(' ', '_')

  value = Deal.const_get("CATEGORY_#{value.upcase}") if attribute == "category"
  value = Deal.const_get("KIND_#{value.upcase}") if attribute == "kind"

  amount.to_i.times do
    deal = FactoryGirl.build "#{status}_deal", :city => City.find_by_name(city), "#{attribute}" => value
    deal.save!(:validate => false) #Uma oferta inativa é inválida
  end
end

Given /^I have (\d+) deals?$/i do |amount|
  FactoryGirl.create :deal, :user => @current_user
end

Given /^(\d+) deals? (?:was|were) registered (\w+)$/ do |amount, date_name|
  date = get_date(date_name)

  amount.to_i.times do
    FactoryGirl.create :deal, :created_at => date, :title => date_name
  end
end

Given /^(\d+) deals? with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, attribute, value, date_name|
  date = get_date(date_name)

  attribute = attribute.gsub(' ', '_')

  value = Deal.const_get("CATEGORY_#{value.upcase}") if attribute == "category"
  value = Deal.const_get("KIND_#{value.upcase}") if attribute == "kind"

  amount.to_i.times do
    FactoryGirl.create :deal, Hash[attribute => value]
  end
end

Given /^(\d+) on sale deals? with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, attribute, value, date_name|
  date = get_date(date_name)

  attribute = attribute.gsub(' ', '_')

  value = Deal.const_get("CATEGORY_#{value.upcase}") if attribute == "category"
  value = Deal.const_get("KIND_#{value.upcase}") if attribute == "kind"

  amount.to_i.times do
    FactoryGirl.create :deal, Hash[attribute => value, :price => nil, :real_price => nil, :kind => Deal::KIND_ON_SALE]
  end
end

Given /^(\d+) deals? from user with name "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, value, date_name|
  date = get_date(date_name)
  user = FactoryGirl.create :confirmed_user, :name => value
  amount.to_i.times do
    FactoryGirl.create :deal, Hash[:user => user]
  end
end

When /^I fill in the deal fields correctly$/ do
  deal = FactoryGirl.build :deal
  fill_in(get_field("deal", "company"), :with => deal.company)
  fill_in(get_field("deal", "description"), :with => deal.description)
  fill_in(get_field("deal", "link"), :with => deal.link)
  fill_in(get_field("deal", "price"), :with => deal.price)
  fill_in(get_field("deal", "real_price"), :with => deal.real_price)
  fill_in(get_field("deal", "title") , :with => deal.title)
  select(Deal.i18n_category(deal.category), :from => get_field("deal", "category")) 
  select(Deal.i18n_kind(deal.kind), :from => get_field("deal", "kind"))
  select(City.first.id, :from => get_field("deal", "city"))
end

When /^I fill in the search field with "([^"]*)"$/ do |search|
  fill_in "search", :with => search
end

Then /^I should see (\d+) deals?$/ do |amount|
  page.all(:xpath, "//div[@class='offer']").length.should == amount.to_i
end

Then /^I should see (\d+) deals? with (\w+) "([^"]*)"$/ do |amount, attribute, value|
  field = get_field("deal", attribute)
  page.all(:xpath, "//div[@class='offer']//strong[contains(@class, '#{field}')]/a[contains(text(), '#{value}')]").length.should == amount.to_i
end

Then /^deal should link to "([^"]*)"$/ do |text|
  page.find(:xpath, "//li[@class='botao']/a")[:href].should == text
end
