class Device < ActiveRecord::Base
	#Virtual attribute to hold the current request object
	#The device model acts as a wrapper around the request and the
	#device modules will extract the data in a device specific format 
  	attr_accessor :current_request

	#Lock down new, so that we have to use find or create devie
	#protected_class_method :new 
  
	belongs_to :player
	has_many :query_transactions
	
	def self.find_or_create_device(request)
		#Lookup the device unique id found in the application controller and see if we have
		#it in the database
		#otherwise, we built it

	    device=find_or_initialize_by_uniqueid(request.parameters[:device_uniqueid])
		if device.new_record? 
	    	device.uniqueid=request.parameters[:device_uniqueid]
	    	device.short_code=generate_unique_short_code
	    	device.save!
	    end
	    
	    #Ok, we have either found or created the device
	    #Now, extend for the device specific module that was calculated in the application controller
	    device_module="Devices::#{request.parameters[:device_type].capitalize}".constantize
	    device.extend(device_module)
	    
	    #Add the request object in, so the parameters can be extracted by the device specific module
	    device.current_request=request
	    return device
	end
	
	private
	
	def self.generate_unique_short_code
		short_code=generate_short_code
		while find_by_short_code(short_code)!=nil
			short_code=generate_short_code
		end
		short_code
	end
	
	def self.generate_short_code
		a=("A".."Z").to_a + ("0".."9").to_a
		short_code=""
		10.times do 
			short_code<<a[rand(a.length-1)]
		end
		short_code
	end
	
end
