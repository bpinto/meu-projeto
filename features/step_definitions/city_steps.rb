#coding: UTF-8

Given /^the city "([^"]*)" exists$/ do |city_name|
  FactoryGirl.create :city, :name => city_name, :state => "Estado"
end
