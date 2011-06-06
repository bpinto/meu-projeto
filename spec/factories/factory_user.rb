require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name 'F_NAME'
    sequence(:email) { |n| "factory#{n}@dealwit.me" }
    password 'F_PASSWORD'
  end

  factory :confirmed_user, :parent => :user do
    after_create { |user| user.confirm! }
  end
end
