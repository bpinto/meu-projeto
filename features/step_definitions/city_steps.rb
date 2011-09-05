#coding: UTF-8

Given /^the city "([^"]*)" exists$/ do |city_name|
  Factory.create :city, :name => city_name
end
