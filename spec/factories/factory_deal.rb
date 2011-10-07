require 'factory_girl'

FactoryGirl.define do
  factory :deal do |f|
    category Deal::CATEGORY_RESTAURANT
    company "F_COMPANY"
    description "F_DESCRIPTION"
    kind Deal::KIND_OFFER
    f.link "http://F_LINK" #O FactoryGirl se perde caso não fique explícito que o método link é do deal.
    price_mask "0,99"
    real_price_mask "1,99"
    title "F_TITLE"

    city
    user
  end

  factory :deal_on_sale, :parent => :deal do
    kind Deal::KIND_ON_SALE
    discount 30
    price_mask nil
    real_price_mask nil
  end

  factory :deal_offer, :parent => :deal do
    kind Deal::KIND_OFFER
  end

  factory :daily_deal, :parent => :deal do
    kind Deal::KIND_DAILY_DEAL
  end

  factory :active_deal, :parent => :deal do
    end_date Date.tomorrow
  end

  factory :inactive_deal, :parent => :deal do
    end_date Date.yesterday
  end
end
