class CreateCitiesUsers < ActiveRecord::Migration
  def change
    create_table "cities_users", :id => false do |t|
      t.column "city_id", :integer, :null => false
      t.column "user_id",  :integer, :null => false
    end
  end
end
