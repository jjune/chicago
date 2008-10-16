class ExtendQueryTransaction < ActiveRecord::Migration
  def self.up
  	add_column :query_transactions, :carrier, :string
  	add_column :query_transactions, :user_agent, :string
  	add_column :query_transactions, :screenwidth, :string
  end

  def self.down
  	remove_column :query_transactions, :carrier
  	remove_column :query_transactions, :user_agent
  	remove_column :query_transactions, :screenwidth
  end
end
