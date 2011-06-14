class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.float 'price',      :null => false
      t.text 'description', :null => false
      t.string 'link',      :null => false
      t.string 'title',     :null => false
      t.string 'kind',      :null => false
      t.integer 'user_id',  :null => false

      t.timestamps
    end
  end
end
