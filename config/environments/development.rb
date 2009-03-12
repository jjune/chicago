# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false
#config.action_view.cache_template_extensions         = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

#added by BG for ActiveMerchant
config.after_initialize do 
  ActiveMerchant::Billing::Base.mode = :test #need to change for prod env
  ActiveMerchant::Billing::Base.gateway_mode = :test #need to change for prod env
end 

PAYPAL_API_CREDENTIALS = { 
:login => 'paypal_1226603926_biz_api1.supersecretlabs.com', 
:password => '1226603931', 
:signature => 'A9cAQs3AOtDvJ7W4wLRwP7y6dhgsAo132C4muED..APElRefC0FACncJ' 
} 
