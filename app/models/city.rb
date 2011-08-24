class City < ActiveRecord::Base
  has_paper_trail

  has_many :deals

  validates :country,   :presence => true
  validates :name,      :presence => true
  validates :state,     :presence => true
end
