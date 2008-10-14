class UpdatePrizePaypal < ActiveRecord::Migration
  def self.up
    add_column :prizes, :"paypal_token", :string
    add_column :prizes, :"paypal_state", :string
    add_column :prizes, :"paypal_prizecost", :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
    add_column :prizes, :"paypal_payer_id", :string 
    add_column :prizes, :"paypal_amount", :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
    add_column :prizes, :"paypal_error", :string
  
  end

  def self.down
    
    	remove_column :prizes, :"paypal_token"
      remove_column :prizes, :"paypal_state"
      remove_column :prizes, :"paypal_prizecost"
      remove_column :prizes, :"paypal_payer_id"
      remove_column :prizes, :"paypal_amount"
      remove_column :prizes, :"paypal_error"
  end
end
