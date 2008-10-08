class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @from        = "Supersecret Administrator"
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://chicago.supersecretlabs.com/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @from        = "Supersecret Administrator"
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://chicago.supersecretlabs.com/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "Supersecret Administrator"
      @subject     = "Account Activation"
      @sent_on     = Time.now
      @body[:user] = user
    end
end
