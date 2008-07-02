class CreatePrizes < ActiveRecord::Migration
  def self.up
    create_table :prizes do |t|
		t.column "name", :string
  		t.column "type", :string
    	t.column "prizearea", :polygon, :null=>false, :srid => 4326, :with_z =>false
    	t.column "center", :point, :null=>false, :srid => 4326, :with_z =>false
      t.timestamps
    end
    
    add_index "prizes", "prizearea", :spatial=>true
    add_index "prizes", "center", :spatial=>true
  end

  def self.down
    drop_table :prizes
  end
end
