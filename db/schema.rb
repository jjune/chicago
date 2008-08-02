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

ActiveRecord::Schema.define(:version => 6) do

  create_table "devices", :force => true do |t|
    t.column "player_id", :integer
    t.column "deviceid", :string
    t.column "carrier", :string
    t.column "device", :string
    t.column "screenwidth", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
  end

# Could not dump table "pg_buffercache" because of following StandardError
#   Unknown type 'oid' for column 'relfilenode' /Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:44:in `table'/Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:42:in `each'/Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:42:in `table'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:70:in `tables'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:61:in `each'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:61:in `tables'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:23:in `dump'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:17:in `dump'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:189/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:188:in `open'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:188/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `call'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:508:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `synchronize'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:494:in `invoke'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:86/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `call'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:508:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `synchronize'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:494:in `invoke'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1931:in `invoke_task'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1948:in `standard_exception_handling'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1903:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1881:in `run'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1948:in `standard_exception_handling'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1878:in `run'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/bin/rake:31/usr/bin/rake:19:in `load'/usr/bin/rake:19

# Could not dump table "pg_freespacemap_pages" because of following StandardError
#   Unknown type 'oid' for column 'reltablespace' /Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:44:in `table'/Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:42:in `each'/Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:42:in `table'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:70:in `tables'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:61:in `each'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:61:in `tables'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:23:in `dump'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:17:in `dump'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:189/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:188:in `open'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:188/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `call'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:508:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `synchronize'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:494:in `invoke'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:86/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `call'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:508:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `synchronize'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:494:in `invoke'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1931:in `invoke_task'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1948:in `standard_exception_handling'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1903:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1881:in `run'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1948:in `standard_exception_handling'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1878:in `run'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/bin/rake:31/usr/bin/rake:19:in `load'/usr/bin/rake:19

# Could not dump table "pg_freespacemap_relations" because of following StandardError
#   Unknown type 'oid' for column 'reltablespace' /Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:44:in `table'/Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:42:in `each'/Users/bgilreath/rails/chicago/vendor/plugins/spatial_adapter/lib/common_spatial_adapter.rb:42:in `table'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:70:in `tables'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:61:in `each'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:61:in `tables'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:23:in `dump'/Library/Ruby/Gems/1.8/gems/activerecord-2.0.2/lib/active_record/schema_dumper.rb:17:in `dump'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:189/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:188:in `open'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:188/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `call'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:508:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `synchronize'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:494:in `invoke'/Library/Ruby/Gems/1.8/gems/rails-2.0.2/lib/tasks/databases.rake:86/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `call'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:546:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:541:in `execute'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:508:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `synchronize'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:501:in `invoke_with_call_chain'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:494:in `invoke'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1931:in `invoke_task'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `each'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1909:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1948:in `standard_exception_handling'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1903:in `top_level'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1881:in `run'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1948:in `standard_exception_handling'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/lib/rake.rb:1878:in `run'/Library/Ruby/Gems/1.8/gems/rake-0.8.1/bin/rake:31/usr/bin/rake:19:in `load'/usr/bin/rake:19

  create_table "prizes", :force => true do |t|
    t.column "name", :string
    t.column "type", :string
    t.column "created_at", :timestamp
    t.column "updated_at", :timestamp
    t.column "prizearea", :polygon, :srid => 4326, :null => false
    t.column "center", :point, :srid => 4326, :null => false
    t.column "prizetype", :string
    t.column "prizeamt", :integer
    t.column "shapeparent", :string
    t.column "winnermsg", :string
    t.column "cheatcode", :string
  end

  add_index "prizes", ["center"], :name => "index_prizes_on_center", :spatial=> true 
  add_index "prizes", ["prizearea"], :name => "index_prizes_on_prizearea", :spatial=> true 

  create_table "query_transactions", :force => true do |t|
    t.column "player_id", :integer, :null => false
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
