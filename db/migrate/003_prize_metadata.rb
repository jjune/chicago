class PrizeMetadata < ActiveRecord::Migration
  def self.up
    add_column :prizes, :"prizetype", :string
    add_column :prizes, :"prizeamt", :integer, :null=>false, :default=>0
    add_column :prizes, :"shapeparent", :string
    add_column :prizes, :"winnermsg", :string
    add_column :prizes, :"cheatcode", :string
  end

  def self.down
  	remove_column :prizes, :"prizetype"
    remove_column :prizes, :"prizeamt"
    remove_column :prizes, :"shapeparent"
    remove_column :prizes, :"winnermsg"
    remove_column :prizes, :"cheatcode"
  end
end
