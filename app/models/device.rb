class Device < ActiveRecord::Base
	#Virtual attribute to hold the current request object
	#The device model acts as a wrapper around the request and the
	#device modules will extract the data in a device specific format 
  	attr_accessor :current_request

	#Lock down new, so that we have to use find or create devie
	private_class_method :new 
  
	belongs_to :player
	has_many :query_transactions
	
	def self.find_or_create_device(request)
		#We only code for Where right now, but this will get built out
		device = find_by_uniqueid(request.parameters[:deviceid])
	    if device.nil? then
	    	device = new
	    	device.uniqueid=request.parameters[:deviceid]
	    	device.short_code=generate_unique_short_code
	    	device.save!
	    end
	    
	    #Extend for the device specific module
	    device.extend(DeviceWhere)
	    
	    #Add the request object in, so the parameters can be extracted
	    device.current_request=request
	    
	    return device
	end
	
	private
	
	def self.generate_unique_short_code
		short_code=generate_short_code
		while Device.find_by_short_code(short_code)!=nil
			short_code=generate_short_code
		end
		short_code
	end
	
	def self.generate_short_code
		a=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"]
		short_code=""
		10.times do 
			short_code<<a[rand(a.length-1)]
		end
		short_code
	end
	
end
