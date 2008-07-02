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

ActiveRecord::Schema.define(:version => 2) do

  create_table "prizes", :force => true do |t|
    t.column "name", :string
    t.column "type", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "prizearea", :polygon, :srid => 4326, :null => false
    t.column "center", :point, :srid => 4326, :null => false
  end

  add_index "prizes", ["center"], :name => "index_prizes_on_center", :spatial=> true 
  add_index "prizes", ["prizearea"], :name => "index_prizes_on_prizearea", :spatial=> true 

end
