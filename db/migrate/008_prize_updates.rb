class PrizeUpdates < ActiveRecord::Migration
  def self.up
  	add_column :prizes, :"cheathint", :string
  	add_column :prizes, :"status", :string
    add_column :prizes, :"quantity", :integer, :null=>false, :default=>0
    add_column :prizes, :"sponsor_id", :integer
    add_column :prizes, :"surfacearea", :float
    
    add_index "prizes", "surfacearea"
  end

  def self.down
  	remove_column :prizes, :"cheathint"
  	remove_column :prizes, :"status"
    remove_column :prizes, :"quantity"
    remove_column :prizes, :"sponsor_id"
    remove_column :prizes, :"surfacearea"
  end
end
