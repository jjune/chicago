#lng, lat, and georuby_point should be defined in every device module at a minimum
module Devices
	module Wince
		
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
	
		def device_type
			if @current_request.parameters["HTTP_X_WAP_PROFILE"].nil?
				"unknown"
			else
				@current_request.parameters["HTTP_X_WAP_PROFILE"]
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
			if @current_request.env["HTTP_UA_PIXELS"].nil?
				"240"
			else
				pixels = @current_request.env["HTTP_UA_PIXELS"].split("x")
				pixels[0]
			end
		end
		
		def textsize
			if screenwidth=="240"
	        	"small"
	      else
	        	"medium"
	      end
		end
		
		def user_agent
			@current_request.user_agent
		end
		
		def jsinclude
			"device_gears"
		end
		
	end
end