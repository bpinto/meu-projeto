#coding: UTF-8

Then /^I should see (\d+) comment$/ do |amount|
  page.all(:xpath, "//div[@class='comment']").length.should == amount.to_i
end

