class UserObserver < ActiveRecord::Observer
  def after_create(user)
    if user.account_type == 'Sponsor'
      UserMailer.deliver_signup_notification(user)
    end
  end

  def after_save(user)
    if user.account_type == 'Sponsor'
      UserMailer.deliver_activation(user) if user.recently_activated?
    end
  end
end
