Given /^(\d+) deals? exists?$/i do |amount|
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

When /^I fill the deal fields correctly$/ do
  deal = Factory.build :deal
  fill_in(get_field("deal", "title") , :with => deal.title)
  fill_in(get_field("deal", "price"), :with => deal.price)
  fill_in(get_field("deal", "link"), :with => deal.link)
  fill_in(get_field("deal", "description"), :with => deal.description)
  select(deal.category.to_s, :from => get_field("deal", "category")) 
  # select(I18n.t "models.deal.category.#{deal.category}", :from => get_field("deal", "category")) 
end

Then /^I should see (\d+) deals?$/i do |amount|
  page.all(:xpath, "//div[@class='offer']").length.should == amount.to_i
end

Then /^deal should link to "([^"]*)"$/ do |text|
  page.find(:xpath, "//div[@class='offer_go']")[:href] == text
end
