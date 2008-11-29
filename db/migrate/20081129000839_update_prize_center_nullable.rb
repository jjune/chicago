class UpdatePrizeCenterNullable < ActiveRecord::Migration
  def self.up
  	execute "ALTER TABLE prizes ALTER COLUMN center DROP NOT NULL "
  end

  def self.down
  	execute "ALTER TABLE prizes ALTER COLUMN center SET NOT NULL "
  end
end
