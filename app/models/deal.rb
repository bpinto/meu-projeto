class Deal < ActiveRecord::Base
  belongs_to :user

  validates :price,       :presence => true
  validates :description, :presence => true
  validates :link,        :presence => true
  validates :type,        :presence => true
end
