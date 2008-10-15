class WhereController < ApplicationController  
 
   #validate query strings
    #Need to make sure Emulators can't win
    #visibility based on carrier or phone type as well
    #This is the first form the device will see
    # Need to determine if current player or not
    #need to be a query start form
    #Might want to show a map here with user's current position
    #Big ass button that says - QUERY AWAY
 
  @wherebr = "&br;"
  @wherebr = @wherebr.to_sym

  @wherenbsp = "&nbsp;"
  @wherenbsp = @wherenbsp.to_sym
 
  def claims
     @xml = Builder::XmlMarkup.new
    
    respond_to do |format|
       format.xml  {render :action => "claims.rss.builder", :layout => false }
     end
  end
  
  #--------------------------------------Cheat Hint Lookup------------------------------------
  def sniff
  
    @xml = Builder::XmlMarkup.new

   #Emulator Guard
   if params[:lng].nil? then
   @lng = "-84.49008"
   else
   @lng = params[:lng]
   end

   if params[:lat].nil? then
   @lat = "33.84275"
   else
   @lat = params[:lat]
   end 
  
   #Device Checks
    @device = Device.find_by_deviceid(params[:deviceid])
    if @device.nil? then
    	@device = Device.new()
    	@device.deviceid = params[:deviceid]
    	@device.device = params[:device]
    	@device.carrier = params[:carrier]
    	@device.screenwidth = params[:screenwidth] 
    	@device.save!

    		#need to retrieve device short code and present to user - whether they win or not
    end

    #test for Emulator
    if @device.screenwidth.nil? then
      @device.screenwidth = "240"
    end

    if @device.carrier.nil? then
    @device.carrier = "Emulator"
    end

    #WHERE required to get the correct generic graphics
    if @device.screenwidth = "176" then
      @textsize = "small"
    else
      @textsize = "medium"
    end
  
    #Cheat code validation check
    if params[:cheatcode].nil? then
      #Friendly error msg
      @cheathint = "You cannot cheat with this code."
    else
      prizewithcheat = Prize.find(params[:cheatcode])
      @cheathint = prizewithcheat.cheathint
    end
    
    respond_to do |format|
      format.xml  {render :xml => @cheathint, :action => "sniff.xml.builder", :layout => false }
    end #respond to
  
  end
  
  
  #-----------------------Look for a Prize-----------------------------
  def snoop
    @xml = Builder::XmlMarkup.new
  
    #Emulator Guard
    if params[:lng].nil? then
      @lng = "-84.49008"
    else
      @lng = params[:lng]
    end
  
    if params[:lat].nil? then
      @lat = "33.84275"
    else
      @lat = params[:lat]
    end
  
    #Device Checks
    @device = Device.find_by_deviceid(params[:deviceid])
   	if @device.nil? then
   		@device = Device.new()
   		@device.deviceid = params[:deviceid]
   		@device.device = params[:device]
   		@device.carrier = params[:carrier]
   		@device.screenwidth = params[:screenwidth] 
   		@device.save!
   		
   		#need to retrieve device short code and present to user - whether they win or not		
   	end
   
   #test for Emulator
   if @device.screenwidth.nil? then
     @device.screenwidth = "240"
   end
   
   if @device.carrier.nil? then
   @device.carrier = "Emulator"
   end
   
   #WHERE required to get the correct generic graphics
   if @device.screenwidth = "176" then
     @textsize = "small"
   else
     @textsize = "medium"
   end

   #Prize Checks 
   prize = Prize.find_winning_prize_by_lng_lat(@lng,@lat,@device)
 
   if not prize.nil? then #We have a winner
     
	  @headline = "You found " + prize.name #tell them they won
	  @playermsg = prize.winnermsg #tell them what they won

    #Tell them how to claim it
    if prize.prizetype == "Message" 
      @standardclaimmsg = ""
    elsif prize.prizetype == "Money"
      @standardclaimmsg = "Login to the Player Dashboard and give us your PayPal email to claim."
      #register too
    elsif prize.prizetype == "Coupon"
      @standardclaimmsg = "Show this coupon from your phone. If you close this screen, your coupon disappears."
    elsif prize.prizetype == "Picture"
      @standardclaimmsg = ""
    elsif prize.prizetype == "File"
      @standardclaimmsg = "Login to the Player Dashboard to claim the File."
    elsif prize.prizetype == "Gold"
      @standardclaimmsg = "Login to the Player Dashboard and track your Gold."
    else 
      @standardclaimmsg = ""
    end 

	  else
	    
	    #Are there hints? - Done by searching area
	    #Is there broadcast news? 
	  
	    	nearest_prizes = Prize.find_nearest_prizes_by_device_not_won(@lng,@lat,1000,@device)

      	if not nearest_prizes.nil? then
      	  
      	  npcount = nearest_prizes.length
      	  
    	    @headline = "You are getting warm"
    	    @playermsg = "There are " + npcount.to_s + " unclaimed prizes around."
    	    @standardclaimmsg = "move around and try again."
        
    	  else
    	    @headline = "Sorry"
    	    @playermsg = "Not even close"
    	    @standardclaimmsg = "move around and try again."
          
    	  end
      	  
	  end #prize check
  
    
    #Builder code formats winning message or losing message
     respond_to do |format|
       format.xml  {render :xml => @device, :action => "snoop.xml.builder", :layout => false }
     end #respond to
  
  end
  
  
  #--------------------------------Static About Page--------------------------------
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
  
  
  def widget
    
      #This works 9/17/08
      #Need to pass a single prize and hints
      
      @xml = Builder::XmlMarkup.new
      #@prizes=Prize.find(:all)
      @device = Device.find_by_deviceid(params[:deviceid])
      
      #Emulator Guard
      if params[:lng].nil? then
      @lng = "-84.49008"
      else
      @lng = params[:lng]
      end

      if params[:lat].nil? then
      @lat = "33.84275"
      else
      @lat = params[:lat]
      end
      
      	if @device.nil? then
      		@device = Device.new()
      		@device.deviceid = params[:deviceid]
      		@device.device = params[:device]
      		@device.carrier = params[:carrier]
      		@device.screenwidth = params[:screenwidth] 
      		@device.save!
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
      
      #http://maps.google.com/staticmap?center=33.84275,-84.49008&zoom=14
      #&size=240x128&maptype=mobile&markers=33.84275,-84.49008,blue&format=png
      #&key=ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q
      #Google static map info
      @googleapikey = "ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q"
      @googlebaseurl = "http://maps.google.com/staticmap?"
      @googlecoord = @lat + "," + @lng
      @googlemapsize = @device.screenwidth + "x128"
      @googleimageurl = @googlebaseurl + "center=" + @googlecoord + "&zoom=14&size=" + @googlemapsize + "&maptype=mobile&markers=" + @googlecoord + ",blue&format=png&key=" + @googleapikey
      @googleimageurl = @googleimageurl.to_sym
      #"http://maps.google.com/staticmap?center=33.84275,-84.49008&zoom=14&size=176x128&maptype=mobile&markers=33.84275,-84.49008,blue&format=png&key=ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q
      #@googleimageurl = @googlebaseurl & "center=" + @googlecenter 
      
      
      
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
          format.xml  { render :xml => @device, :action => "widget.xml.builder", :layout => false }
        end

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
  	end
  		
  	current_point = Point.from_lon_lat(params[:lng],params[:lat],4326)
  	prizes = Prize.find_all_by_prizearea(current_point)
  	
  	
    #Do we have this person's device ID on file?
    #Is this valid query
  	
  
    #prizes.each do |prize|
  	#@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')
    
    
    
  		 
  end
  
end
