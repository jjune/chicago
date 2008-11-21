# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false







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