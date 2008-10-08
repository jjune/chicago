class QueryPrizeController < ApplicationController

  def index
  	#@map = GMap.new("map_div")

    #@map.control_init(:large_map => false, :map_type => false)

    #@map.center_zoom_init([37.4419, -122.1419], 13)
    #@gmark = Variable.new("gmark")
    
    
    #gmark = GMarker.new([37.4419, -122.1419],:draggable=>true,:title => "Device User")
    
    #@map.overlay_init(gmark)
	#@map.event_init(gmark,"dragend","function() {alert(1);}")

  end
  
  def find
  	@map = Variable.new("map")
	#current_marker = Point.from_lon_lat(params[:lng],params[:lat],4326)
  	#prizes = Prize.find_all_by_prizearea(current_marker)
  	#prizes = []
  	#prizes= Prize.find_all_exact_by_georuby_point(current_marker)
  	#prizes =Prize.find_all_exact_by_lng_lat(params[:lng],params[:lat])
  		#We need the device to find out what was already won
		device = Device.find_by_deviceid('35')
  	prize = Prize.find_winning_prize_by_lng_lat(params[:lng],params[:lat],device)
  	
  	#if prizes.length>0
  	if not prize.nil?
  		#@polygon = GPolygon.from_georuby(prizes[0].prizearea,'#0000FF','5','1','#0000FF','0.2')
  		@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')
  		render :update do |page|
	   		#notice=prizes.length
			notice="winner!"	
			page.hide 'notice'
			
			page.replace_html 'notice', notice
			page.visual_effect :appear, 'notice', :duration => 0.5
			
			page << @map.clear_overlays
			page << @map.add_overlay(@polygon)	
		 end
	else
		render :update do |page|
	   		notice="Nothing for you beeotch!!!!"
	
			page.hide 'notice'
			
			page.replace_html 'notice', notice
			page.visual_effect :appear, 'notice', :duration => 0.5
		 end  			
  	end
  end
  
  def nearest
  	@map = Variable.new("map")
  	
  	#All nearby prizes
  	#nearest_prizes = Prize.find_nearest_prizes(params[:lng],params[:lat],1000)
  	
  	#Nearby prizes this device has not won
  	device = Device.find_by_deviceid('35')
  	nearest_prizes = Prize.find_nearest_prizes_by_device_not_won(params[:lng],params[:lat],1000,device)
  	
  	if not nearest_prizes.nil?
  		
  		render :update do |page|
	   		
			notice="Locals found"	
			page.hide 'notice'
			
			page.replace_html 'notice', notice
			page.visual_effect :appear, 'notice', :duration => 0.5
			
			page << @map.clear_overlays
		
			nearest_prizes.each do |prize|
				@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')	
				page << @map.add_overlay(@polygon)
			end	
		 end
	 else
		render :update do |page|
   			notice="No locals for you beeotch!!!!"

			page.hide 'notice'
		
			page.replace_html 'notice', notice
			page.visual_effect :appear, 'notice', :duration => 0.5
		 end  		 
	end
  end
  	
end
