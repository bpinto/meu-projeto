#coding: UTF-8
Given /^I have (\d+) deals?$/i do |amount|
  FactoryGirl.create :deal, :user => @current_user
end

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
  params = fix_params(attribute, value)

  amount.to_i.times do
    deal = FactoryGirl.build "#{status}_deal", :city => City.find_by_name(city), "#{attribute}" => value
    deal.save!(:validate => false) #Uma oferta inativa é inválida
  end
end

Given /^(\d+) deals? (?:was|were) registered (\w+)$/ do |amount, date_name|
  date = get_date(date_name)

  amount.to_i.times do
    FactoryGirl.create :deal, :created_at => date, :title => date_name
  end
end

Given /^(\d+) deal with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*) with (\d+) comments?$/ do |amount, attribute, value, date_name, amount_of_comments|
  date = get_date(date_name)
  params = fix_params(attribute, value)

  amount.to_i.times do
    deal = FactoryGirl.create :deal, params
    amount_of_comments.to_i.times do
      comment = deal.comments.build(:comment => "comment")
      comment.save
    end
  end
end

Given /^(\d+) deals? with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*) with (\d+) up votes? and (\d+) down votes?$/ do |amount, attribute, value, date_name, amount_up_votes, amount_down_votes|
  date = get_date(date_name)
  params = fix_params(attribute, value)
  amount.to_i.times do
    deal = FactoryGirl.create :deal, params
    deal.up_votes = amount_up_votes
    deal.down_votes = amount_down_votes
    deal.save
  end
end

Given /^(\d+) deals? with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, attribute, value, date_name|
  date = get_date(date_name)
  params = fix_params(attribute, value)

  amount.to_i.times do
    FactoryGirl.create :deal, params
  end
end

Given /^(\d+) deals? from "([^"]*)" (?:was|were) registered (\w*)$/i do |amount, city, date_name|
  date = get_date(date_name)

  amount.to_i.times do
    deal = FactoryGirl.build :deal, :city => City.find_by_name(city), :created_at => date
    deal.save!(:validate => false) #Uma oferta inativa é inválida
  end
end

Given /^(\d+) deals? from "([^"]*)" with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, city, attribute, value, date_name|
  date = get_date(date_name)
  params = fix_params(attribute, value)

  amount.to_i.times do
    deal = FactoryGirl.build :deal, :city => City.find_by_name(city), :created_at => date, "#{attribute}" => value
    deal.save!(:validate => false) #Uma oferta inativa é inválida
  end
end

Given /^(\d+) on sale deals? with ([\w ]+) as "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, attribute, value, date_name|
  date = get_date(date_name)
  params = fix_params(attribute, value)

  amount.to_i.times do
    FactoryGirl.create :deal_on_sale, params
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
  fill_in(get_field("deal", "price_mask"), :with => deal.price_mask)
  fill_in(get_field("deal", "real_price_mask"), :with => deal.real_price_mask)
  fill_in(get_field("deal", "title") , :with => deal.title)
  select(Deal.i18n_category(deal.category), :from => get_field("deal", "category")) 
  select(Deal.i18n_kind(deal.kind), :from => get_field("deal", "kind"))
  select(City.first.name, :from => get_field("deal", "city"))
end

When /^I fill in the search field with "([^"]*)"$/ do |search|
  fill_in "search", :with => search
end

Then /^I should see (\d+) deals?$/ do |amount|
  page.all(:xpath, "//div[@class='main']//div[@class='offer']").length.should == amount.to_i
end

Then /^I should see (\d+) deals? with (\w+) "([^"]*)"$/ do |amount, attribute, value|
  field = get_field("deal", attribute)
  page.all(:xpath, "//div[@class='main']//div[@class='deal']//strong[@class='#{field}']/a[contains(text(), '#{value}')]").length.should == amount.to_i
end

Then /^I should see (\d+) side deal with (\w+) "([^"]*)" in (\w+) list$/ do |amount, attribute, value, list_class|
  field = get_field("deal", attribute)
  page.all(:xpath, "//div[@class='side']//div[@class='#{list_class}']//div[@class='deal']//strong[@class='#{field}']/a[contains(text(), '#{value}')]").length.should == amount.to_i
end

Then /^deal should link to "([^"]*)"$/ do |text|
  page.find(:xpath, "//li[@class='botao']/a")[:href].should == text
end


def fix_params(attribute, value)
  hash = {}

  value = case attribute
          when "category"
            Deal.const_get("CATEGORY_#{value.upcase}")
          when "kind"
            Deal.const_get("KIND_#{value.upcase}")
          else
            value
          end

  if attribute == "price"
    attribute = "price_mask"
    hash["real_price_mask"] = (BigDecimal.new(value) + 1).to_s
  elsif attribute == "discount"
    real_price = 100.to_f
    price = real_price * (100 - value.to_f) / 100
    hash["real_price_mask"] = real_price.to_s
    hash["price_mask"] = price.to_s
  else
    attribute = attribute.gsub(' ', '_')
  end

  hash.merge attribute.to_s => value
end
