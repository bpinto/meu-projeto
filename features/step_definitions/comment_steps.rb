#coding: UTF-8

Then /^I should see (\d+) comment$/ do |amount|
  page.all(:xpath, "//div[contains(@class,'avaliacao')]").length.should == amount.to_i
end

