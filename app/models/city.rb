class City < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :users
  has_many :deals

  validates :country,   :presence => true
  validates :name,      :presence => true
  validates :state,     :presence => true

  RIO_DE_JANEIRO = 1
end
