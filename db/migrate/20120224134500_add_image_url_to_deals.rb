class AddImageUrlToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :image_url, :string
  end
end
