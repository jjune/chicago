# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "devices", :force => true do |t|
    t.column "player_id", :integer
    t.column "deviceid", :string
    t.column "carrier", :string
    t.column "device", :string
    t.column "screenwidth", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

  create_table "prizes", :force => true do |t|
    t.column "name", :string
    t.column "type", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "prizearea", :polygon, :srid => 4326, :null => false
    t.column "center", :point, :srid => 4326, :null => false
    t.column "prizetype", :string
    t.column "prizeamt", :integer, :default => 0, :null => false
    t.column "shapeparent", :string
    t.column "winnermsg", :string
    t.column "cheatcode", :string
  end

  add_index "prizes", ["center"], :name => "index_prizes_on_center", :spatial=> true 
  add_index "prizes", ["prizearea"], :name => "index_prizes_on_prizearea", :spatial=> true 

  create_table "query_transactions", :force => true do |t|
    t.column "player_id", :integer
    t.column "device_id", :integer
    t.column "prize_id", :integer
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "coordinate", :point, :srid => 4326, :null => false
  end

  create_table "users", :force => true do |t|
    t.column "type", :string
    t.column "login", :string
    t.column "email", :string
    t.column "crypted_password", :string, :limit => 40
    t.column "salt", :string, :limit => 40
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "remember_token", :string
    t.column "remember_token_expires_at", :timestamp
    t.column "company_name", :string
    t.column "first_name", :string
    t.column "last_name", :string
    t.column "address1", :string
    t.column "address2", :string
    t.column "city", :string
    t.column "state", :string
    t.column "zipcode", :string
    t.column "phone_number", :string
  end

end
