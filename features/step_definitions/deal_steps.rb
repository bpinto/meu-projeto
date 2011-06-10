When /^I fill the deal fields correctly$/ do
  deal = Factory.build :deal
  fill_in("deal_title" , :with => deal.title)
  fill_in("deal_price", :with => deal.price)
  fill_in("deal_link", :with => deal.link)
  fill_in("deal_description", :with => deal.description)
  select("Bebidas", :from => "deal_type")
end
