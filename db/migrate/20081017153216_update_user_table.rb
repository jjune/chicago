class UpdateUserTable < ActiveRecord::Migration
  def self.up
    add_column :users, :type, :string
    remove_column :users, :account_type
  end

  def self.down
    remove_column :users, :type
    add_column :users, :account_type, :string
  end
end