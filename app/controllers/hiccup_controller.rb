class HiccupController < ApplicationController

skip_before_filter :verify_authenticity_token

#This is the PayPal Instant Payment Notification
#It is named this way to prevent people from hacking

def paypal_ipn
  @raw = request.raw_post
  logger.debug "Raw Post = #{@raw}"
  logger.debug "params = #{params}"
  @ipn = Ipn.new
  @ipn.payer_email = params[:payer_email]
  @ipn.payment_gross = params[:mc_gross1]
  @ipn.payment_date = params[:payment_date]
  @ipn.brad = @raw
  @ipn.verify_sign = ipnconfirm
  @ipn.save
end


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
