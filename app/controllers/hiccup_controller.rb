class HiccupController < ApplicationController

#This is the PayPal Instant Payment Notification
#It is named this way to prevent people from hacking

def ipnconfirm

uri = URI.parse("http://www.sandbox.paypal.com/cgi-bin/webscr")
status = nil
Net::HTTP.start(uri.host, uri.port) do |request|
  status = request.post(uri.path, @raw + "&cmd=_notify-validate").body
end

logger.debug "status = '#{status}'"

status == "VERIFIED"

end #ipnconfirm


end
