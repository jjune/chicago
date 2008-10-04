class Prize < ActiveRecord::Base
	has_many :query_transactions
	belongs_to :sponsor
	
	validates_presence_of :name, :prizetype, :prizearea, :center, :winnermsg, :quantity, :sponsor_id
	
	#validates_uniqueness_of :cheatcode #need to supress error message here or allow non-unique via query
	
	def self.find_all_exact_by_georuby_point(point)
		return find_all_exact_by_lng_lat(point.lng,point.lat)
	end
	
	def self.find_all_exact_by_lng_lat(lng,lat)
		query = base_query(lng,lat)
		prizes = Prize.find_by_sql(query)
		return prizes
	end
	
	def self.find_winning_prize_by_georuby_point(point)
		return find_winning_prize_by_lng_lat(point.lng,point.lat)
	end
	
	def self.find_winning_prize_by_lng_lat(lng,lat)
		query = base_query(lng,lat) +
				"ORDER BY ST_Area(prizearea) ASC " +
				"LIMIT 1"	
		prize = Prize.find_by_sql(query)
		if prize.length>0
			return prize[0]
		else
			return nil
		end
	end
	
	#1. return count of active prizes within a specified radius from users' point
	#2. nearest neighbor to users point
	#3. return count of CLAIMED prizes within a specified radius from users' point
	
	#4. limit to 1 cheatcode
	
	protected
	
	def self.base_query(lng,lat)
		query = "SELECT * FROM prizes " +
				"WHERE ST_Contains(prizearea,GeomFromText('POINT("+lng+" "+lat+")',4326)) " +
				"AND _ST_Contains(prizearea,GeomFromText('POINT("+lng+" "+lat+")',4326)) "
		return query
	end
end
