class UpdateDeviceForFactory < ActiveRecord::Migration
  def self.up
  	remove_column :devices, :carrier 
  	remove_column :devices, :device
  	remove_column :devices, :screenwidth
  	
  	rename_column :devices, :deviceid, :uniqueid	
  end

  def self.down
  	add_column :devices, :carrier, :string
  	add_column :devices, :device, :string
  	add_column :devices, :screenwidth, :string
  	
  	rename_column :devices, :uniqueid, :deviceid
  end
end
