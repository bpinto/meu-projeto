require 'factory_girl'

FactoryGirl.define do
  factory :deal do |f|
    price "0.99"
    description "F_DESCRIPTION"
    f.link "F_LINK" #O FactoryGirl se perde caso não fique explícito que o método link é do deal.
    title "F_TITLE"
    type "Bebidas" #TODO: Refatorar
    user
  end
end
