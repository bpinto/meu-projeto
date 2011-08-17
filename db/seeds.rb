# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
#
puts 'SETTING UP DEFAULT USER LOGIN'
Factory.create :confirmed_user, :username => 'bruno', :password => '123qwe', :password_confirmation => '123qwe'
