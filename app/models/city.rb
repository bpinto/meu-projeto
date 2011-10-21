class City < ActiveRecord::Base
  has_paper_trail

  has_and_belongs_to_many :users
  has_many :deals

  validates :country,   :presence => true
  validates :name,      :presence => true
  validates :state,     :presence => true

  scope :order_by_state, order('cities.state').order('cities.name')
  scope :without_national_offer, where("cities.name <> ?", "Oferta Nacional")
  scope :get_national_offer, where("cities.name = ?", "Oferta Nacional")

  def self.hash_by_states
    hash_of_states = {}
    cities = City.order_by_state.without_national_offer
    national = City.get_national_offer
    hash_of_states = {"Oferta Nacional" => [[national[0].name, national[0].id]]}
    last_state = cities[0].state
    cities_of_last_state = []
    cities.each do |c|
      if c.state == last_state
        cities_of_last_state = cities_of_last_state + [[c.name, c.id]]
      else
        hash_of_states.merge!({last_state => cities_of_last_state})
        last_state = c.state
        cities_of_last_state = [[c.name, c.id]]
      end
    end
    hash_of_states.merge!({last_state => cities_of_last_state})
  end

end
