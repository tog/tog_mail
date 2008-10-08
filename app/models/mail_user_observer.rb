class MailUserObserver  < ActiveRecord::Observer
  observe :user
  def after_save(user)
    user.create_default_folders! if user.recently_activated?
  end
end
