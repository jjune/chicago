class Player < User
	has_many :query_transactions
	has_many :devices
	
	def prize_items(options={})
		PrizeItem.find(:all, :conditions=>{:device_id=>devices}.merge(options),:include=>:prize)
	end
end
