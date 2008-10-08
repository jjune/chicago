class CreatePrizeItems < ActiveRecord::Migration
  def self.up
    create_table :prize_items do |t|
	t.column "prize_id", :integer
	t.column "device_id", :integer
	t.column "status", :string
      t.timestamps
    end
  end

  def self.down
    drop_table :prize_items
  end
end
