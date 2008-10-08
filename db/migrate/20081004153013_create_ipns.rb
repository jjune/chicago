class CreateIpns < ActiveRecord::Migration
  def self.up
    create_table :ipns do |t|

      #check number or dat_time data types and integer

      t.column :payment_gross, :float
      t.column :mc_currency, :string
      t.column :mc_gross, :float
      t.column :mc_fee, :float
      t.column :payment_fee, :float
      t.column :receiver_email, :string
      t.column :receiver_id, :string
      t.column :payer_email, :string
      t.column :payer_id, :string
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :address_status, :string
      t.column :address_name, :string
      t.column :address_country, :string
      t.column :payment_status, :string
      t.column :address_city, :string
      t.column :address_street, :string
      t.column :address_zip, :string
      t.column :address_country_code, :string
      t.column :residence_country, :string
      t.column :action, :string
      t.column :address_state, :string
      t.column :payer_status, :string
      t.column :business, :string
      t.column :controller, :string
      t.column :payment_date, :datetime
      t.column :test_ipn, :float
      t.column :payment_type, :string
      t.column :notify_version, :float
      t.column :charset, :string
      t.column :txn_id, :string
      t.column :txn_type, :string
      t.column :verify_sign, :string           

      t.timestamps
    end
  end

  def self.down
    drop_table :ipns
  end
end
