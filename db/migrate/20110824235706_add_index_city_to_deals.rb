class AddIndexCityToDeals < ActiveRecord::Migration
  def up
    add_index :deals, :city_id
  end

  def down
    remove_index  :deals, :city_id
  end
end
