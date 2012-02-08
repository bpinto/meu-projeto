class AddFacebookOptionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_share_offer, :boolean, :null => false, :default => true
    add_column :users, :facebook_vote_offer, :boolean, :null => false, :default => true
    add_column :users, :facebook_follow_user, :boolean, :null => false, :default => true
  end
end
