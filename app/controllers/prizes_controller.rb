class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.xml
  before_filter :login_required
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

  # GET /prizes/1
  # GET /prizes/1.xml
  def show
    @header_above_partial_path = "global/hdr_above"
    @header_partial_path = "prizes/hdr_prizelab"
    @header_below_partial_path = "global/hdr_below"
    @hdr_below_title = "Prize Viewer"
    
    @footer_above_partial_path = "global/ftr_above"
    #@footer_partial_path = "prizes/hdr_prizelab"
    @footer_below_partial_path = "global/ftr_below"
    #@ftr_below_title = "Dashboard"
    
    @prize = Prize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prize }
    end
end
  

  # GET /prizes/new
  # GET /prizes/new.xml
  def new
    @header_above_partial_path = "global/hdr_above"
    @header_partial_path = "prizes/hdr_prizelab"
    @header_below_partial_path = "global/hdr_below"
    @hdr_below_title = "Create a Prize"
    
    @footer_above_partial_path = "global/ftr_above"
    #@footer_partial_path = "prizes/hdr_prizelab"
    @footer_below_partial_path = "global/ftr_below"
    #@ftr_below_title = "Dashboard"
    
    @prize = Prize.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prize }
    end
  end

  # GET /prizes/1/edit
  def edit
    @header_above_partial_path = "global/hdr_above" 
    @header_partial_path = "prizes/hdr_prizelab"
    @header_below_partial_path = "global/hdr_below"
    @hdr_below_title = "Edit Prize"
    
    @footer_above_partial_path = "global/ftr_above"
    #@footer_partial_path = "prizes/hdr_prizelab"
    @footer_below_partial_path = "global/ftr_below"
    #@ftr_below_title = "Dashboard"
    
    @prize = Prize.find(params[:id])
  end

  # POST /prizes
  # POST /prizes.xml
  def create  
    #@prize = Prize.new(params[:prize])
    RAILS_DEFAULT_LOGGER.error("post:"+params[:prize][:prizearea])
   	points = params[:prize][:prizearea].split(/:/)
   
   	points.collect! do |point|
   		RAILS_DEFAULT_LOGGER.error("point:"+point.to_s+"\n")
   		j=point.split(/,/)
   		RAILS_DEFAULT_LOGGER.error("\n" + j[0].to_s + "," + j[1].to_s + "\n")
   		[j[1].to_f, j[0].to_f]
   	end
   	
   	#points.collect! { |x| x.split(/,/)}
   	#@points.collect! {|x| x.split(/,/)}
    #points = Array.new()
    #str_point.each {|p| 
    #j=p.split(/,/)
    #points.push(j)
    

    
    
    
	@prize = Prize.new(	:name => params[:prize][:name],
						:prizearea => Polygon.from_coordinates([points],4326), 
						:center => Point.from_x_y(params[:center_lng],params[:center_lat],4326),
						:type => "prize",
					  :prizetype => params[:prize][:prizetype],
          	:prizeamt => params[:prize][:prizeamt],
          	:cheatcode => params[:prize][:cheatcode],
          	:winnermsg => params[:prize][:winnermsg]
					  )
    respond_to do |format|
      if @prize.save
        flash[:notice] = 'Prize was successfully created.'
        format.html { redirect_to(@prize) }
        format.xml  { render :xml => @prize, :status => :created, :location => @prize }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prize.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prizes/1
  # PUT /prizes/1.xml
  def update
    @prize = Prize.find(params[:id])

    respond_to do |format|
      if @prize.update_attributes(params[:prize])
        flash[:notice] = 'Prize was successfully updated.'
        format.html { redirect_to(@prize) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prize.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.xml
  def destroy
    @prize = Prize.find(params[:id])
    @prize.destroy

    respond_to do |format|
      format.html { redirect_to(prizes_url) }
      format.xml  { head :ok }
    end
  end
end
