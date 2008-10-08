class SponsorController < ApplicationController
 
   #before_filter :login_required
   layout 'dashboard'
  def index
     @header_above_partial_path = "global/hdr_above"
      @header_partial_path = "prizes/hdr_prizelab"
      @header_below_partial_path = "global/hdr_below"
      @hdr_below_title = "Dashboard"

      @footer_above_partial_path = "global/ftr_above"
      #@footer_partial_path = "prizes/hdr_prizelab"
      @footer_below_partial_path = "global/ftr_below"
      #@ftr_below_title = "Dashboard"

      @prizes = Prize.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @prizes }
      end
  end
end
