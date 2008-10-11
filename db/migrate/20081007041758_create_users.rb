class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code, :string, :limit => 40
      t.column :activated_at, :datetime
      t.column :type, :string

      t.column :first_name, :string
      t.column :last_name, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :city,     :string
      t.column :state,    :string
      t.column :zipcode,  :string
      t.column :country, :string
      t.column :phone_number, :string

    end
  end

  def self.down
    drop_table "users"
  end
end
