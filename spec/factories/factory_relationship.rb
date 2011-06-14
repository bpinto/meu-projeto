require 'factory_girl'

FactoryGirl.define do
  factory :relationship do |f|
    f.association :follower, :factory => :user
    f.association :followed, :factory => :user
  end
end
