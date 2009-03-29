# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
  
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  
  #Add some info to the requests about the current devices
  #Used by the models and views for proper renderin
  before_filter :detect_devices  
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '300b2091d4a6076d28b0273f3282a6c7'
  
  #added by BG - ActiveMerchant
  filter_parameter_logging :creditcard 

  

  private
    def detect_devices
    	if !request.parameters[:carrier].nil?
			request.format = :jin
    		request.parameters[:device_type]="where"
    		request.parameters[:device_uniqueid]=request.parameters[:deviceid]
    	elsif request.env["USER-AGENT"][/Windows CE/]
    		request.format = :html
    		request.parameters[:device_type]="wince" 
    	elsif request.env["HTTP_USER_AGENT"][/iPhone/]
    		request.format = :iphone 
    		request.parameters[:device_type]="iphone"
		else
			request.format = :stub
			request.parameters[:device_type]="stub"
    		request.parameters[:device_uniqueid]=request.remote_ip()
    	end
    end

end
