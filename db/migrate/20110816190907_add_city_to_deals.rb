class AddCityToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals, :city, :string,          :null => false
    add_index :deals, :city
  end

  def self.down
    remove_index :deals, :city
    remove_column :deals, :city
  end
end
