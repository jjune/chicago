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
  
  end
  
  def chk4prize
  end
  
end
