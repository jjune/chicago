class CreateQueryTransactions < ActiveRecord::Migration
  def self.up
    create_table :query_transactions do |t|
	  t.column "coordinate", :point, :null=>false, :srid => 4326, :with_z =>false
	  t.column "player_id", :integer, :null=>false
	  t.column "device_id", :integer
	  t.column "prize_id",  :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :query_transactions
  end
end
