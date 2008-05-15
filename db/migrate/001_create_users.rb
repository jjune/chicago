class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :type,                      :string

      # common attributes      
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
      
      # attributes for type=player
      t.column :device_type,               :string
      
      # attributes for type=sponsor        
      t.column :company_name,              :string
    end
  end

  def self.down
    drop_table "users"
  end
end
