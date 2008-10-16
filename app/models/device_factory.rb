class DeviceFactory
	def self.find_or_create_device(request)
		#We only code for Where right now, but this will get built out
		device = Device.find_by_uniqueid(request.parameters[:deviceid])
	    if device.nil? then
	    	device = Device.new
	    	device.uniqueid=request.parameters[:deviceid]
	    	device.save!
	    end
	    
	    #Extend for the device specific module
	    device.extend(DeviceWhere)
	    
	    #Add the request object in, so the parameters can be extracted
	    device.current_request=request
	    
	    return device
	end
end