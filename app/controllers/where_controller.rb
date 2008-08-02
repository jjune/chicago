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
  
  def query
  
  	#@device = Device.find(:all, :conditions => ["deviceid = ?", params[:deviceid]])
	@device = Device.find_by_deviceid(params[:deviceid])
  	  	
  	if @device.nil?
  		@device = Device.new()
  		@device.deviceid = params[:deviceid]
  		@device.device = params[:device]
  		@device.carrier = params[:carrier]
  		@device.screenwidth = params[:screenwidth] 
  		@device.save!
  	else
  		@player = @device.player	
  	end
  		
  	current_point = Point.from_lon_lat(params[:lng],params[:lat],4326)
  	prizes = Prize.find_all_by_prizearea(current_point)
  	
  	
    #Do we have this person's device ID on file?
    #Is this valid query
  	
  
    #prizes.each do |prize|
  	#@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')
    
    @qt = QueryTransaction.new()
    @qt.coordinate = current_point
    @qt.player = @player unless @player.nil?
    @qt.device = @device
    #Todo add prize here if they win
    @qt.save!
    
    
  		 
  end
  
end
