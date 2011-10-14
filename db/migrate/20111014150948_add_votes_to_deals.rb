class AddVotesToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :up_votes, :integer, :null => false, :default => 0
    add_column :deals, :down_votes, :integer, :null => false, :default => 0
  end
end
