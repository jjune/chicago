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
  
  def welcomewidget
  
  #This is the first form the device will see
  # Need to determine if current player or not
  #need to be a query start form
  #Might want to show a map here with user's current position
  #Big ass button that says - QUERY AWAY
  
  respond_to do |format|
    #format.xml  { render :xml => @prizes, :action => "gen_xml.xml.builder", :layout => false }
  end
  
  end
  
  def aboutus
   @xml = Builder::XmlMarkup.new
   
   #Need to check for device, and deliver unique cheat code that will reveal prize of how to play game.
   
     @device = Device.find_by_deviceid(params[:deviceid])

     	if @device.nil? then
     		@device = Device.new()
     		@device.deviceid = params[:deviceid]
     		@device.device = params[:device]
     		@device.carrier = params[:carrier]
     		@device.screenwidth = params[:screenwidth] 
     		@device.save!
     	else
     		@player = @device.player	
     	end
     
     #test for Emulator
     if @device.screenwidth.nil? then
       @device.screenwidth = "240"
     end
     
     if @device.carrier.nil? then
     @device.carrier = "Emulator"
     end
     
     if @device.screenwidth = "176" then
       @textsize = "small"
     else
       @textsize = "medium"
     end
   
     respond_to do |format|
       format.xml  {render :xml => @device, :action => "aboutus.xml.builder", :layout => false }
     end
  end
  
  
  def gen_xml
    
      #This works 9/17/08
      #Need to pass a single prize and hints
      
      @xml = Builder::XmlMarkup.new
      @prizes=Prize.find(:all)
      @device = Device.find_by_deviceid(params[:deviceid])

      	if @device.nil? then
      		@device = Device.new()
      		@device.deviceid = params[:deviceid]
      		@device.device = params[:device]
      		@device.carrier = params[:carrier]
      		@device.screenwidth = params[:screenwidth] 
      		@device.save!
      	else
      		@player = @device.player	
      	end
      
      #test for Emulator
      if @device.screenwidth.nil? then
        @device.screenwidth = "240"
      end
      
      if @device.carrier.nil? then
      @device.carrier = "Emulator"
      end
      
      if @device.screenwidth = "176" then
        @textsize = "small"
      else
        @textsize = "medium"
      end
      
      #Need to add custom WHERE message set here.
      #This will change default message above map from:
      #Our satellites have spotted you here:
      #Agent Anonymous - we have you positioned below:
      #personal messages like: 
      #Agent G-dawg you have 3 secret items to claim on the website
      #A special cheat for today only
      #Site maintenance messages
      #other stuff
      
      
        respond_to do |format|
          format.xml  { render :xml => @prizes, :action => "gen_xml.xml.builder", :layout => false }
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
