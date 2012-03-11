class AddCreditToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :credit, :decimal, :precision => 8, :scale => 2, :null => false, :default => 0.00
  end
end
