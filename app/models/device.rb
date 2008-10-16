class Device < ActiveRecord::Base
	#Virtual attribute to hold the current request object
	#The device model acts as a wrapper around the request and the
	#device modules will extract the data in a device specific format 
  	attr_accessor :current_request
  
	belongs_to :player
	has_many :query_transactions
end
