require 'factory_girl'

FactoryGirl.define do
  factory :deal do |f|
    category Deal::CATEGORY_RESTAURANT
    company "F_COMPANY"
    description "F_DESCRIPTION"
    kind Deal::KIND_OFFER
    sequence(:link) { |n| "http://F_LINK/#{n}" } #O FactoryGirl se perde caso não fique explícito que o método link é do deal.
    price_mask "0,99"
    real_price_mask "1,99"
    title "F_TITLE"
    up_votes = 0
    down_votes = 0
    image_url = "http://F_IMAGE"

    city
    user
  end

  factory :deal_on_sale, :parent => :deal do
    kind Deal::KIND_ON_SALE
    discount 30
    price_mask nil
    real_price_mask nil
    image_url = "http://F_IMAGE"
  end

  factory :deal_offer, :parent => :deal do
    kind Deal::KIND_OFFER
    image_url = "http://F_IMAGE"
  end

  factory :daily_deal, :parent => :deal do
    kind Deal::KIND_DAILY_DEAL
    image_url = "http://F_IMAGE"
  end

  factory :active_deal, :parent => :deal do
    end_date Date.tomorrow
    image_url = "http://F_IMAGE"
  end

  factory :inactive_deal, :parent => :deal do
    end_date Date.yesterday
    image_url = "http://F_IMAGE"
  end
end
