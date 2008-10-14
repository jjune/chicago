class ChangeIpns < ActiveRecord::Migration
  def self.up
  
      change_column :ipns, :payment_gross, :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
      change_column :ipns, :mc_gross, :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
      change_column :ipns, :mc_fee, :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
      change_column :ipns, :payment_fee, :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
      change_column :ipns, :test_ipn, :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
      change_column :ipns, :notify_version, :decimal, :precision => 8, :scale => 2, :null=>false, :default=>0
  
  end

  def self.down
  end
end
