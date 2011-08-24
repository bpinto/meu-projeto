class City < ActiveRecord::Base
  has_paper_trail

  validates :country,   :presence => true
  validates :name,      :presence => true
  validates :state,     :presence => true
end
