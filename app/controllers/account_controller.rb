class AccountController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'register') unless logged_in? || User.count > 0
  end

  def login
    @title = 'SupersecretLabs Login'
    @action_class = 'login'
    
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      #redirect_back_or_default(:controller => '/account', :action => 'index')
      if self.current_user.user_type == 'Player'
        redirect_to(:controller => 'player')
      else
        redirect_to(:controller => 'prizes')
      end      
     # flash[:notice] = "Logged in successfully with" + " " + current_user.user_type
    else
     # assumes authentication was unsuccessful
     # TODO: return result code based description of why the authentication failed
     flash[:error] = "ERROR: Authentication Failed."
    end
  end
  
  def process_player_registration
    @user = User.new(params[:user])
    @user.type = 'player'
    
    if @user.save
      flash[:notice] = "User account #{@user.login} successfully created."
      redirect_to(:action => 'login')
    else
      @action_class = 'register'
      @title = "New Player Registration"
      render :action => 'player_registration'
    end
     
  end
  
  def process_sponsor_registration
    @user = User.new(params[:user])
    @user.type = 'sponsor'

    if @user.save
      flash[:notice] = "User account #{@user.login} successfully created."
      redirect_to(:action => 'login')
    else
      @action_class = 'register'
      @title = "New Sponsor Registration"
      render :action => 'sponsor_registration'
    end
  end
  
  def player_registration
    @action_class = 'register'
    @title = "New Player Registration"
    @user = Player.new(params[:user])
  end
  
  def check_shortcode
    if params[:shortcode] == "123"
       @shortcode_device = "yes"
    elsif params[:shortcode] == ""
       @shortcode_device = "empty"
    else
       @shortcode_device = "no"
    end
   render :partial => 'global/shortcode_device_description'
  end
  

  def register_login
    @action_class = 'register'
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'register_contact')
    flash[:notice] = "Login successfully created"
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "Uh oh, problem."
    render :action => 'register_login'
  end
  
  
  
  def sponsor_registration
      @title = "New Sponsor Registration"
      @action_class = 'register'
      @user = Sponsor.new(params[:user])
      return unless request.post?
      @user.save!
      self.current_user = @user
      redirect_back_or_default(:controller => '/account', :action => 'index')
      flash[:notice] = "Thanks for signing up!"
    rescue ActiveRecord::RecordInvalid
      render :action => 'sponsor_registration'    
  end
  

  
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    #redirect_back_or_default(:controller => '/account', :action => 'index')
    redirect_back_or_default(:controller => '/account', :action => 'login')
  end
end
