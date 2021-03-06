class WhereController < ApplicationController  
 
    #validate query strings
    #WHERE UserAgent = [device]/[carrier]/[version]/Profile/MIDP-2.0 Configuration/CLDC-1.0
    #Need to make sure Emulators can't win
    #visibility based on carrier or phone type as well
    #Need to determine if current player or not
    
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
	  @device = Device.find_or_create_device(request)

    #Cheat code validation check
    if params[:cheatcode].nil? then
      #Friendly error msg
      @cheathint = "You cannot spoof the system. Please backup and provide a valid code. Your phone may self destruct if you attempt this again."
    else
      prizewithcheat = Prize.find_by_cheatcode(params[:cheatcode])
      #there might be multiple prizes with duplicate cheat code
      #how about a randomizer?
      if not prizewithcheat.nil? then
        @cheathint = prizewithcheat.cheathint
      else
        @cheathint = "Your source for the code cannot be trusted. Your cover may be compromised. Please return to the beginning and forget this ever happened."
      end
    end
    
    respond_to do |format|
      format.xml  {render :xml => @cheathint, :action => "sniff.xml.builder", :layout => false }
    end #respond to
  end
  
  
  #-----------------------Look for a Prize-----------------------------
  def snoop
    @xml = Builder::XmlMarkup.new
  	@device = Device.find_or_create_device(request)

   #Prize Checks 
   prize = Prize.find_winning_prize_for_device(@device)
 
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
	  
	    #Randomize distance used in NN
	    querydistance = rand(1500)
	    nearest_prizes = Prize.find_nearest_prizes_by_device_not_won(querydistance,@device)

      	if not nearest_prizes.nil? then
      	  npcount = nearest_prizes.length
    	    @headline = "You are near a secret object. Make sure there are only trusted people around you."
    	    @playermsg = "In the area " + npcount.to_s + " objects are unclaimed."
    	    @standardclaimmsg = "Move around a bit and try again."
    	  else
    	    @headline = "Where are you?"
    	    @playermsg = "We cannot discern clearly that you are near a secret object."
    	    @standardclaimmsg = "Move around significantly and try again."
    	  end
      	  
	  end #prize check
  
    
    #Builder code formats winning message or losing message
     respond_to do |format|
       format.xml  {render :xml => @device, :action => "snoop.xml.builder", :layout => false }
       format.html
       format.json {render :json =>@playermsg.to_json }
     end #respond to
  
  end
  
  
  #--------------------------------Static About Page--------------------------------
  def aboutus
  	@xml = Builder::XmlMarkup.new
	  @device = Device.find_or_create_device(request)
   
	  #Need to check for device, and deliver unique cheat code that will reveal prize of how to play game.
   
    #need to add help cheat code here.
   
     respond_to do |format|
       format.xml  {render :xml => @device, :action => "aboutus.xml.builder", :layout => false }
     end
  end
  
  
  def widget
    
      #This works 9/17/08
      #Need to pass a single prize and hints
      
      @xml = Builder::XmlMarkup.new
      @device = Device.find_or_create_device(request)
      
     
      #http://maps.google.com/staticmap?center=33.84275,-84.49008&zoom=14
      #&size=240x128&maptype=mobile&markers=33.84275,-84.49008,blue&format=png
      #&key=ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q
      #Google static map info
      if request.parameters[:device_type]=="where"
      @googleapikey = "ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q"
      @googlebaseurl = "http://maps.google.com/staticmap?"
      @googlecoord = @device.lat + "," + @device.lng
      @googlemapsize = @device.screenwidth + "x128"
      @googleimageurl = @googlebaseurl + "center=" + @googlecoord + "&zoom=14&size=" + @googlemapsize + "&maptype=mobile&markers=" + @googlecoord + ",blue&format=png&key=" + @googleapikey
      @googleimageurl = @googleimageurl.to_sym
      #"http://maps.google.com/staticmap?center=33.84275,-84.49008&zoom=14&size=176x128&maptype=mobile&markers=33.84275,-84.49008,blue&format=png&key=ABQIAAAA6RZP3ZouLBJsRfEv4s3jzhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxT6qAbsBjBmEKqdpIQq_13niSn_-Q
      #@googleimageurl = @googlebaseurl & "center=" + @googlecenter 
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
          	format.stub
          	format.html
        	format.jin  { render :xml => @device, :action => "widget.xml.builder", :layout => false }
        end

  end

  
  def query
  
  	@device = Device.find_or_create_device(request)	  		
  	current_point = Point.from_lon_lat(device.lng,device.lat,4326)
  	prizes = Prize.find_all_by_prizearea(current_point)
  	
  	
    #Do we have this person's device ID on file?
    #Is this valid query
  	
  
    #prizes.each do |prize|
  	#@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')
    
    
    
  		 
  end
  
end
