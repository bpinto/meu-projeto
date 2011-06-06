class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer 'followed_id'
      t.integer 'follower_id'

      t.timestamps
    end
  end
end
