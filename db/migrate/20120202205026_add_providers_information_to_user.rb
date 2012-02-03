class AddProvidersInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :uid, :integer
    add_column :users, :provider, :string
    add_column :users, :avatar_url, :string
  end
end
