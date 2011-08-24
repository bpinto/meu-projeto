require 'factory_girl'

FactoryGirl.define do
  factory :deal do |f|
    category Deal::CATEGORY_DRINK
    company "F_COMPANY"
    description "F_DESCRIPTION"
    kind Deal::KIND_OFFER
    f.link "http://F_LINK" #O FactoryGirl se perde caso não fique explícito que o método link é do deal.
    price 0.99
    real_price 1.99
    title "F_TITLE"
    city "F_CITY"

    user
  end

  factory :deal_with_discount, :parent => :deal do
    real_price 1.99
  end
end
