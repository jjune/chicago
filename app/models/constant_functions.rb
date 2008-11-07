module ConstantFunctions
	def find_all
		return self.local_constants
	end
	
	def find_all_as_hash
		all_status={}
		self.local_constants.each do |status|
			all_status.merge! :"#{status}" =>eval("self::#{status}")
		end
		all_status
	end
end