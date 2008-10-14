class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.xml

  #layout 'dashboard'
  
  def index
    @header_above_partial_path = "global/hdr_above"
    @header_partial_path = "prizes/hdr_prizelab"
    @header_below_partial_path = "global/hdr_below"
    @hdr_below_title = "Dashboard"
    
    @footer_above_partial_path = "global/ftr_above"
    #@footer_partial_path = "prizes/hdr_prizelab"
    @footer_below_partial_path = "global/ftr_below"
    #@ftr_below_title = "Dashboard"
    
    
    
    #This is the problem because I used old technique for pagination
    #@prize_pages, @prizes = paginate :prizes, :per_page => 3
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
          	:winnermsg => params[:prize][:winnermsg],
          	:quantity => params[:prize][:quantity]
					  )
					  
	#
	#if !(params[:prize][:quantity].to_i >0)
	#	quantity=1
	#else
	#	quantity = params[:prize][:quantity].to_i
	#end
	
	#for num in (1..quantity)
	#	@prize.prize_items << PrizeItem.new(:status=>"active")
	#end
	
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

  
  #Added BG ActiveMerchant
  #Obviously should be dropped into a table - but for release 1 - NO!
  
  PRODUCTS = { 
  
  'Message' => { 
    :price => 2.00, :description => 'SuperSecret Labs Message Item' 
    }, 
  
  'Money' => { 
    :price => 5.00, :description => 'SuperSecret Labs Money Item' 
    }, 

  'Coupon' => { 
    :price => 1.00, :description => 'SuperSecret Labs Coupon Item' 
    }, 

  'Picture' => { 
    :price => 4.00, :description => 'SuperSecret Labs Picture Item' 
    }, 

  'File' => { 
    :price => 10.00, :description => 'SuperSecret Labs File Item' 
    }, 

  'Gold' => { 
    :price => 1.00, :description => 'SuperSecret Labs Gold Item' 
    }, 
    
  } 
  
  
  def express_checkout 
    
    product = params[:order][:product] 
    
    #like to add token confirmation so we know they use web page to create (no hacking!)
    
    #This needs to change
    #We want to enforce Status Change on successful completion
    #order = Order.create( 
     # :state => 'open', 
      #:product => product, 
      #:amount => PRODUCTS[product][:price] 
      #) 
  
  prize = Prize.find(params[:id])
  
  prizecost = PRODUCTS[prize.prizetype][:price]
  
      @response = gateway.setup_purchase( 
        amount_in_cents(prizecost), 
        :ip => request.remote_ip, 
        :description => PRODUCTS[prize.prizetype][:description], 
        :return_url => url_for(:action => :express_checkout_complete), 
        :cancel_return_url => url_for(:action => :cancel_checkout) 
        ) 
  
  if !@response.success? 
    paypal_error(@response) 
  else
    paypal_token = @response.params['token'] 
    order.update_attributes( 
      :paypal_token => paypal_token, 
      :state => 'purchase_setup' 
      ) 
    paypal_url = gateway.redirect_url_for(paypal_token) 
    redirect_to "#{paypal_url}&useraction=commit" 
  end #!@response.success?
  
  end #express_checkout 
  
  #called on return from PayPal
  def express_checkout_complete 
    paypal_token = params[:token] 
    @order = Order.find_by_paypal_token(paypal_token) 
    @details = gateway.details_for(paypal_token) 
  
    if !@details.success?
      paypal_error(@details) 
    else 
      logger.info "Customer name: #{@details.params['name']}" 
      logger.info "Customer e-mail: #{@details.params['payer']}" 
      @response = gateway.purchase( 
        amount_in_cents(@order.amount), 
        :token => @details.params['token'], 
        :payer_id => @details.params['payer_id'] 
        )
         
      if !@response.success? 
        paypal_error(@response) 
      else 
        @order.update_attribute(:state, 'closed') 
        @purchase = Purchase.create( 
          :amount => @response.params['gross_amount'], 
          :order => @order 
          ) 
      end #!@response.success? 
    end #!@details.success?
  end #express_checkout_complete
    
  def cancel_checkout 
    @order= Order.find_by_paypal_token(params[:token]) 
    @order.update_attribute(:state,'cancelled') 
  end 
  
  
  private 

    def gateway 
      @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(PAYPAL_API_CREDENTIALS) 
    end 
   
    def paypal_error(response) 
      render :text => response.message 
    end 

    def amount_in_cents(amount) 
      (amount.round(2) * 100).to_i 
    end
  #end #private IS THIS NECESSARY?


end #controller
