class SponsorController < ApplicationController
 
   #before_filter :login_required
   layout 'dashboard'
  def index

     
      #@footer_partial_path = "prizes/hdr_prizelab"
      #@ftr_below_title = "Dashboard"

      @prizes = Prize.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @prizes }
      end
  end
end
