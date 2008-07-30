class WhereController < ApplicationController  
  def show
    
    #validate query strings
    #Need to make sure Emulators can't win
    #visibility based on carrier or phone type as well
    
     @prize = Prize.find(params[:id])

      respond_to do |format|
          #format.xml  { render :xml => @prize }    
        format.jin  { render :jin => @prize }
          #format.bwg  { render :xml => @prize }
      end
  
    
  end
  
  def debugwhere
    #intentionally left blank
  end
  
  def chk4prize
  
    #Do we have this person's device ID on file?
    #Is this valid query
  
    current_marker = Point.from_lon_lat(params[:lng],params[:lat],4326)
    prizes = Prize.find_all_by_prizearea(current_marker)
  
    #prizes.each do |prize|
  	#@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')
  		 
  end
  
end
