# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout 'account'
  # render new.rhtml
  def new
    @title = 'SupersecretLabs Login'
    @action_class = 'login'
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
       if self.current_user.account_type == 'Player'
          redirect_to(:controller => 'player')
        else
          redirect_to(:controller => 'prizes')
        end
    else
      flash[:error] = "ERROR: Authentication Failed."
      redirect_to :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
end
