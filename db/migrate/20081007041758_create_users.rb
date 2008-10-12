class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
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
      t.column :account_type, :string

      # attributes for type=sponsor        
      t.column :first_name, :string, :limit => 20
      t.column :last_name, :string, :limit => 20
      t.column :address1, :string, :limit => 50
      t.column :address2, :string, :limit => 50
      t.column :city,     :string,  :limit => 20
      t.column :state,    :string
      t.column :zipcode,  :string
      t.column :country, :string
      t.column :phone_number, :string
      t.column :terms_agreement, :string
    end
  end

  def self.down
    drop_table :users
  end
end
