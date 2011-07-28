class AddMissingFieldsToDeal < ActiveRecord::Migration
  def change
    add_column    :deals, :address,     :string
    add_column    :deals, :category,    :integer,   :null => false
    add_column    :deals, :company,     :string,    :null => false
    add_column    :deals, :discount,    :decimal,   :precision => 8, :scale => 2
    add_column    :deals, :end_date,    :datetime
    add_column    :deals, :real_price,  :decimal,   :precision => 8, :scale => 2
  end

  def up
    remove_column :deals, :kind
    add_column    :deals, :kind,        :integer,   :null => false

    remove_column :deals, :price
    add_column    :deals, :price,  :decimal,   :precision => 8, :scale => 2
  end

  def down
    remove_column :deals, :kind
    add_column :deals, :kind, :string, :null => false

    remove_column :deals, :price
    add_column    :deals, :price,  :float
  end
end
