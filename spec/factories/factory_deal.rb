require 'factory_girl'

FactoryGirl.define do
  factory :deal do
    price "0.99"
    text "F_TEXT"
    link "F_LINK"
    title "F_TITLE"
    type "T_TYPE"
    user
  end
end
