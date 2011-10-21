class ChangeDealLinkFromStringToText < ActiveRecord::Migration
  def up
    change_table :deals do |t|
      t.change :link, :text, :null => false
    end
  end

  def down
    change_table :deals do |t|
      t.change :link, :text, :null => false
    end
  end
end
