class IpnsTextAdjust < ActiveRecord::Migration
  def self.up
    change_column :ipns, :brad, :text
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration 
  end
end
