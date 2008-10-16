module DeviceWhere
	
	def lng
		#Emulator Guard
	    if @current_request.parameters[:lng].nil?
	      "-84.49008"
	    else
	      @current_request.parameters[:lng]
	    end
	end
	
	def lat
		if @current_request.parameters[:lat].nil?
			"33.84275"
    	else
      		@current_request.parameters[:lat]
    	end
	end

	def device_type
		if @current_request.parameters[:device].nil?
			"unknown"
		else
			@current_request.parameters[:device]
		end
	end
	
	def carrier
		if @current_request.parameters[:carrier].nil?
			"Emulator"
		else
			@current_request.parameters[:carrier]
		end
	end
	
	def screenwidth
		if @current_request.parameters[:screenwidth].nil?
			"240"
		else
			@current_request.parameters[:screenwidth]
		end

	def user_agent
		@current_request.user_agent
	end
	
end