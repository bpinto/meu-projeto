Given /^(\d+)(?:| other) deals? exists?$/i do |amount|
  amount.to_i.times do
    Factory.create :deal
  end
end

Given /^(\d+) deals? (?:was|were) registered (\w+)$/ do |amount, date_name|
  date = get_date(date_name)

  amount.to_i.times do
    Factory.create :deal, :created_at => date, :title => date_name
  end
end

Given /^I have (\d+) deals?$/i do |amount|
  Factory.create :deal, :user => @current_user
end

Given /^(\d+) deals? with (\w+) as "([^"]*)" (?:was|were) registered (\w*)$/ do |amount, attribute, value, date_name|
  date = get_date(date_name)
  value = Deal.const_get("CATEGORY_#{value.upcase}") if attribute == "category"
  value = Deal.const_get("KIND_#{value.upcase}") if attribute == "kind"

  amount.to_i.times do
    Factory.create :deal, Hash[attribute => value]
  end
end

When /^I fill in the deal fields correctly$/ do
  deal = Factory.build :deal
  fill_in(get_field("deal", "company"), :with => deal.company)
  fill_in(get_field("deal", "description"), :with => deal.description)
  fill_in(get_field("deal", "link"), :with => deal.link)
  fill_in(get_field("deal", "price"), :with => deal.price)
  fill_in(get_field("deal", "real_price"), :with => deal.real_price)
  fill_in(get_field("deal", "title") , :with => deal.title)
  select(Deal.i18n_category(deal.category), :from => get_field("deal", "category")) 
  select(Deal.i18n_kind(deal.kind), :from => get_field("deal", "kind"))
  select(City::RIO_DE_JANEIRO, :from => get_field("deal", "city"))
end

Then /^I should see (\d+) deals?$/i do |amount|
  page.all(:xpath, "//div[@class='offer']").length.should == amount.to_i
end

Then /^deal should link to "([^"]*)"$/ do |text|
  page.find(:xpath, "//li[@class='botao']/a")[:href] == text
end
