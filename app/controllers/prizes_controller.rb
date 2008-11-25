class PrizesController < ApplicationController
  # GET /prizes
  # GET /prizes.xml

  before_filter :login_required
  layout 'dashboard'
  def index
    
    #This is the problem because I used old technique for pagination
    #@prize_pages, @prizes = paginate :prizes, :per_page => 3
    @prizes = Prize.find_all_by_sponsor_id(current_user.id)
    #@prizes = Prize.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prizes }
    end
  end

  def show
  	@bodyscript = 'onload="initialize()" onunload="GUnload()"'    
    @prize = Prize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prize }
    end
  end

  def new
    #@bodyscript = 'onload="initialize()" onunload="GUnload()"'
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

  def create  
   	points = params[:prize][:prizearea].split(/:/)
   
   	points.collect! do |point|
   		j=point.split(/,/)
   		[j[1].to_f, j[0].to_f]
   	end

  	@prize = Prize.new(params[:prize])
	@prize.prizearea = Polygon.from_coordinates([points],4326)
	@prize.center = Point.from_x_y(params[:center_lng],params[:center_lat],4326)
	@prize.sponsor_id = current_user.id
	@prize.quantity=1
	@prize.status=Prize::Status::Hold
	@prize.zoom=params[:zoom]

      if @prize.save
        flash[:notice] = 'Prize was successfully created.'
        #format.html { redirect_to(@prize) }
        #format.xml  { render :xml => @prize, :status => :created, :location => @prize }
        
        ##Need to test if edit prize - 
        
        redirect_to :controller => 'prizes', :action => 'express_checkout', :id => @prize.id, :sponsor_id => @prize.sponsor_id
        
      else
        redirect_to :controller => :prizes, :action => :new
        #format.html { render :action => "new" }
        #format.xml  { render :xml => @prize.errors, :status => :unprocessable_entity }
      end

  end

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

def confirmation
    @bodyscript = 'onload="initialize()" onunload="GUnload()"'    
    @prize = Prize.find(params[:id])


end
  
  def prize_type_select
    @prize_type = params[:prize_prizetype]
    
    if @prize_type == 'money'
      render :update do |page|
        page[:prize_type_menu].show
      end
    else
      
      render :update do |page|
        page[:prize_type_menu].hide
      end      
    end
  end
  
  def query_transactions
  	@query_transactions=QueryTransaction.find(:all)
  end
  	
  
  def show_cheathint
    @cheatcode = params[:prize_cheatcode]
    
    if @cheatcode.nil? || @cheatcode == ""
      render :update do |page|
        page[:cheat_hint].hide
      end
    else
      render :update do |page|
        page[:cheat_hint].show
      end
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
    
  #like to add token confirmation so we know they use web page to create (no hacking!)
  #sponsor id should come from session - so that only auth'd user can pay for his prizes.
  #@current_user.id
  #sponsor_id = @current_user.id
  logger.info("Brad Current User = " + @current_user.id.to_s)
  logger.info("Brad Prize = " + params[:id])
  logger.info("Brad Sponsor = " + params[:sponsor_id])
  
  #having trouble with this line of code - doesn't like my condition
  prize = Prize.find_by_id_and_sponsor_id(params[:id],params[:sponsor_id], :conditions => ["paypal_state IS DISTINCT FROM 'closed'"])
  #prize = Prize.find_by_id_and_sponsor_id(params[:id],params[:sponsor_id]) #this works
  
  #AND prize.paypal_state IS DISTINCT FROM 35
  
  if !prize.nil? then
    logger.info("Prize " + params[:id] + " for Sponsor " + params[:sponsor_id] + " found by query.")
    
    prizecost = PRODUCTS[prize.prizetype.capitalize][:price]
    
    @response = gateway.setup_purchase(
      amount_in_cents(prizecost), 
      :ip => request.remote_ip, 
      :description => PRODUCTS[prize.prizetype.capitalize][:description], 
      :return_url => url_for(:action => :express_checkout_complete), 
      :cancel_return_url => url_for(:action => :cancel_checkout) 
      ) 
  
    if !@response.success? 
      logger.info("Paypal ERROR")
      paypal_error(@response) 
    else
      paypal_token = @response.params['token'] 
      prize.update_attributes( 
        :paypal_token => paypal_token, 
        :paypal_state => 'purchase_setup', 
        :paypal_prizecost => prizecost
        ) 
    
        logger.info("Paypal token = " + paypal_token) 
        logger.info("Paypal state = " + 'purchase_setup') 
    
        paypal_url = gateway.redirect_url_for(paypal_token) 
        redirect_to "#{paypal_url}&useraction=commit" 

    end #!@response.success?
  else
    #need to throw an error to the UI
    logger.info("Prize " + params[:id] + " for Sponsor " + params[:sponsor_id] + " already has PayPal status of closed.")
    
    #Either you already paid
    #You don't own the prize
    
    
  end #no prize found to check out  
end #express_checkout 
  
  
#called on return from PayPal
def express_checkout_complete 
  paypal_token = params[:token] 
  @prize = Prize.find_by_paypal_token(paypal_token, :conditions => ["paypal_state = 'purchase_setup'"]) 
  @details = gateway.details_for(paypal_token) 
  
  if !@details.success?
    #paypal has reported error back to our system
    paypal_error(@details) 
  else 
      
    #might want to add to debug
    logger.info "Customer name: #{@details.params['name']}" 
    logger.info "Customer e-mail: #{@details.params['payer']}" 
    
    @response = gateway.purchase( 
      amount_in_cents(@prize.paypal_prizecost), 
      :token => @details.params['token'], 
      :payer_id => @details.params['payer_id'] 
      )
       
    if !@response.success? 
      paypal_error(@response) 
    else 
      @prize.update_attributes(
      :paypal_state => 'closed',
      :paypal_amount => @response.params['gross_amount'] 
      ) 
    
      #send to prize confirmation page   
    end #!@response.success? 
  end #!@details.success?
end #express_checkout_complete

    
def cancel_checkout 
  @prize = Prize.find_by_paypal_token(params[:token]) 
  @prize.update_attribute(:paypal_state,'cancelled') 
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
