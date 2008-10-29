class PrizeItem < ActiveRecord::Base
	belongs_to :prize
	belongs_to :device
	
	#This module is used to manage and document statuses of a prize item
	module Status
		Win="win"
		Claimed="claimed"
		
		def self.find_all
			return self.local_constants
		end
		
		def self.find_all_as_hash
			all_status={}
			self.local_constants.each do |status|
				all_status.merge! :"#{status}" =>eval("self::#{status}")
			end
			all_status
		end
	end
end

