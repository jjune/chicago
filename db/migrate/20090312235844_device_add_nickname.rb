class DeviceAddNickname < ActiveRecord::Migration
  def self.up
  	add_column :devices, :nickname, :string
  end

  def self.down
  	remove_column :devices, :nickname
  end
end
