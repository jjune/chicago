class UpdateUserInformation < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :city,     :string
    add_column :users, :state,    :string
    add_column :users, :zipcode,  :string
    add_column :users, :country, :string
    add_column :users, :phone_number, :string
    remove_column :users, :device_type, :string
  end

  def self.down
  	remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address1
    remove_column :users, :address2
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zipcode
    remove_column :users, :country
    remove_column :users, :phone_number
    add_column :users, :device_type, :string
  end
end
