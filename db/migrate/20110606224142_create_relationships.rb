class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer 'followed_id', :null => false
      t.integer 'follower_id', :null => false

      t.timestamps
    end
  end
end
