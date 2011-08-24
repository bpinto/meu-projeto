class CreateCities < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string 'name',      :null => false
      t.string 'state',     :null => false
      t.string 'country',   :null => false

      t.timestamps
    end

    add_index :cities, :name

    remove_index  :deals, :city
    remove_column :deals, :city
    add_column    :deals, :city, :integer, :null => false
  end

  def down
    remove_index  :cities, :name
    drop_table    :cities

    remove_column :deals, :city
    add_column    :deals, :city, :string, :null => false
    add_index     :deals, :city
  end
end
