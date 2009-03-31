#lng, lat, and georuby_point should be defined in every device module at a minimum
module Devices
	module Stub
		
		def lng
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
		
		def georuby_point
			Point.from_lon_lat(lng,lat,4326)
		end
		
		def user_agent
			@current_request.user_agent
		end
		
		def screenwidth
			"800"
		end
		
		def textsize
			"medium"
		end
	end
end