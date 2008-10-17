class AddShortCodeToDevice < ActiveRecord::Migration
  def self.up
  	add_column :devices, :short_code, :string
  end

  def self.down
  	remove_column :devices, :short_code
  end
end
