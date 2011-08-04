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

  hash = {}
  hash[attribute.to_s] = value

  amount.to_i.times do
    Factory.create :deal, hash
  end
end

When /^I fill the deal fields correctly$/ do
  deal = Factory.build :deal
  fill_in(get_field("deal", "title") , :with => deal.title)
  fill_in(get_field("deal", "price"), :with => deal.price)
  fill_in(get_field("deal", "link"), :with => deal.link)
  fill_in(get_field("deal", "description"), :with => deal.description)
  select(deal.kind, :from => get_field("deal", "kind")) 
end

Then /^I should see (\d+) deals?$/i do |amount|
  page.all(:xpath, "//div[@class='offer']").length.should == amount.to_i
end
