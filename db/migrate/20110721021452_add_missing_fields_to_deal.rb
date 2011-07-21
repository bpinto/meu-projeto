class AddMissingFieldsToDeal < ActiveRecord::Migration
  def change
    add_column :deals, :category,   :string,    :null => false
    add_column :deals, :company,    :string,    :null => false
    add_column :deals, :discount,   :float
    add_column :deals, :end_date,   :datetime,  :null => false
    add_column :deals, :real_price, :float
  end
end
