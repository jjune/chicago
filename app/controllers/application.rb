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
    	request.parameters[:device_type]="where"
    	request.parameters[:device_uniqueid]=request.parameters[:deviceid]
    	#request.format = :iphone if request.env["HTTP_USER_AGENT"][/iPhone/]
    end

  
end
