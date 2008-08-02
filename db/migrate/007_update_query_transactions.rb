class UpdateQueryTransactions < ActiveRecord::Migration
  def self.up
  	change_column :query_transactions, :player_id, :integer, :null=>true
  end

  def self.down
  	change_column :query_transactions, :player_id, :integer, :null=>false
  end
end
