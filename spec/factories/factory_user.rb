require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name 'F_NAME'
    email 'factory@dealwit.me'
    password 'F_PASSWORD'
  end
end
