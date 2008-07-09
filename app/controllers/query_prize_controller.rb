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
	current_marker = Point.from_lon_lat(params[:lng],params[:lat],4326)
  	prizes = Prize.find_all_by_prizearea(current_marker)
  
  	prizes.each do |prize|
  		@polygon = GPolygon.from_georuby(prize.prizearea,'#0000FF','5','1','#0000FF','0.2')
  		render :update do |page|
	   		notice=prizes.length
	
			page.hide 'notice'
			
			page.replace_html 'notice', notice
			page.visual_effect :appear, 'notice', :duration => 0.5
			
			page << @map.clear_overlays
			page << @map.add_overlay(@polygon)	
  		end
  		
  	end
  end
  	
end
