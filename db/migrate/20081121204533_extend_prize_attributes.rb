class ExtendPrizeAttributes < ActiveRecord::Migration
  def self.up
  	add_column :prizes, :linecolor, :string	
  	add_column :prizes, :linethickness, :string	
  	add_column :prizes, :fillcolor, :string	
	add_column :prizes, :zoom, :integer	
  end

  def self.down
  	remove_column :prizes, :linecolor
  	remove_column :prizes, :linethickness
  	remove_column :prizes, :fillcolor
	remove_column :prizes, :zoom
  end
end
