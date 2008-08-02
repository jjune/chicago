class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
		t.column "player_id", :integer
    	t.column "deviceid", :string
		t.column "carrier", :string
		t.column "device", :string
		t.column "screenwidth", :string
      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
