class Prize < ActiveRecord::Base
	has_many :query_transactions
	has_many :prize_items
	belongs_to :sponsor
	
	validates_presence_of :name, :prizetype, :prizearea, :center, :winnermsg, :quantity   #, :sponsor_id This evidently is not populated
	
	#validates_uniqueness_of :cheatcode #need to supress error message here or allow non-unique via query
		
	def self.find_all_exact_by_georuby_point(point)
		return find_all_exact_by_lng_lat(point.lng,point.lat)
	end
	
	def self.find_all_exact_by_lng_lat(lng,lat)
		query = base_query(lng,lat)
		prizes = Prize.find_by_sql(query)
		return prizes
	end
	
	def self.find_winning_prize_by_georuby_point(point,device)
		return find_winning_prize_by_lng_lat(point.lng,point.lat,device)
	end
	
	def self.find_winning_prize_by_lng_lat(lng,lat,device)
		#Get an array of the prize id's already won
		already_won_prize_ids=already_won_prize_ids(device)
		
		#Ok here is the query, it is built in chunks to possibly support gameplay options
		query = base_prize_query(lng,lat)
		query<< "AND quantity>0"
		query<< one_prize_per_device(device)
		query<<	"ORDER BY ST_Area(prizearea) ASC "
		query<<	"LIMIT 1"	
				
		#TODO - probably need optomistic locking here
		#This comes back as an array of prizes, but will be zero or one prize because of the LIMIT 1
		prize = Prize.find_by_sql(query)
		
		#Ok, see if we have a winner, or just return nil
		if prize.length>0
			#We have a winner, get the winning prize and reduce the quantity by one
			#This is where we need the lock, since somone else could have reduced the quanity
			#since we just won and now the quantity is zero
			winning_prize = prize[0]
			winning_prize.quantity = winning_prize.quantity-1
			#Now create the item instance
			winning_prize_item=PrizeItem.new
			winning_prize_item.prize=winning_prize
			winning_prize_item.device=device
			winning_prize_item.status="win"
			#We use a transaction because we only want to reduce quantity if the item is also created
			transaction do
				winning_prize.save!
				winning_prize_item.save!
			end
			log_query(winning_prize,device,lng,lat)
			return winning_prize
		else
			#Loser!  Just log it and send back nil
			log_query(nil,device,lng,lat)
			return nil
		end
	end
	
	def self.find_nearest_prizes(lng,lat,distance)
		query=base_nearest_query(lng,lat,distance)		
		nearest_prizes = Prize.find_by_sql(query)
		
		if nearest_prizes.length>0
			return nearest_prizes
		else
			return nil
		end
	end
	
	def self.find_nearest_prizes_by_device_not_won(lng,lat,distance,device)
		query=base_nearest_query(lng,lat,distance)
		query<<one_prize_per_device(device)
		nearest_prizes = Prize.find_by_sql(query)
		
		if nearest_prizes.length>0
			return nearest_prizes
		else
			return nil
		end
	end
	

	def self.already_won_prize_ids(device)	
		query = "SELECT prize_id "
		query << "FROM prize_items "
		query << "WHERE device_id=" + device.id.to_s
		
		already_won_prize_ids = ActiveRecord::Base.connection.select_values(query)
	end
	
	protected
	
	def self.one_prize_per_device(device)
		already_won_prize_ids=already_won_prize_ids(device)
		
		if already_won_prize_ids.length>0
			return	"AND id NOT IN ("+already_won_prize_ids.join(",")+")" 
		else
			return ""
		end
	end
	
	def self.base_prize_query(lng,lat)
		query = "SELECT * "
		query<<	"FROM prizes " 
		query<<	"WHERE ST_Contains(prizearea,GeomFromText('POINT("+lng+" "+lat+")',4326)) "
		query<<	"AND _ST_Contains(prizearea,GeomFromText('POINT("+lng+" "+lat+")',4326)) "
	end
	
	def self.base_nearest_query(lng,lat,distance)
		#This is a big ugly query, but we need to convert to 2163 to get distances in meters
		#2163 only works for the US, so we need to add more logic here when doing distance query's
		#for international polygons
		query = "SELECT * "
		query<<	"FROM prizes "
		query<< "WHERE ST_DWithin(transform(prizearea,2163),transform(GeomFromText('POINT("+lng+" "+lat+")',4326),2163),"+distance.to_s+") " 
		query<<	"AND NOT ST_Contains(transform(prizearea,2163),transform(GeomFromText('POINT("+lng+" "+lat+")',4326),2163)) "
		query<<	"AND NOT _ST_Contains(transform(prizearea,2163),transform(GeomFromText('POINT("+lng+" "+lat+")',4326),2163)) "
	end
	
	def self.log_query(prize,device,lng,lat)
		qt = QueryTransaction.new()
    	qt.coordinate = Point.from_lon_lat(lng,lat,4326)
    	qt.player = device.player if device.player
    	qt.device = device
    	qt.prize = prize unless prize.nil?
    	qt.save!
	end
end
