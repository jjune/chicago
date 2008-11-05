class PrizeItem < ActiveRecord::Base
	belongs_to :prize
	belongs_to :device
	
	#This module is used to manage and document statuses of a prize item
	module Status
		extend ConstantFunctions
		
		Win="win"
		Claimed="claimed"
	end
end

