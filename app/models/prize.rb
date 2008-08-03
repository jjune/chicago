class Prize < ActiveRecord::Base
	has_many :query_transactions
	belongs_to :sponsor
		
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
		return prize
	end
	
	protected
	
	def self.base_query(lng,lat)
		query = "SELECT * FROM prizes " +
				"WHERE ST_Contains(prizearea,GeomFromText('POINT("+lng+" "+lat+")',4326)) " +
				"AND _ST_Contains(prizearea,GeomFromText('POINT("+lng+" "+lat+")',4326)) "
		return query
	end
end
