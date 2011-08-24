require 'factory_girl'

FactoryGirl.define do
  factory :city do |f|
    name "F_CITY"
    state "F_STATE"
    country "F_COUNTRY"
  end
end
