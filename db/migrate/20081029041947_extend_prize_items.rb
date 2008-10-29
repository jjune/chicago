class ExtendPrizeItems < ActiveRecord::Migration
  def self.up
  	add_column :prize_items, :coordinate, :point, :srid => 4326, :with_z =>false
  	add_column :prize_items, :claim_date, :datetime
  end

  def self.down
  	remove_column :prize_items, :coordinate
  	remove_column :prize_items, :claim_date
  end
end
