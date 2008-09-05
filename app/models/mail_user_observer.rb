class MailUserObserver  < ActiveRecord::Observer
  observe :user
  def after_save(user)
    if user.recently_activated?
      Tog::Config["plugins.tog_mail.messages.default_folders"].each(" "){|folder_type|
        folder_type.strip!
        Folder.new(:name => folder_type,
        :deletable => false,
        :folder_type => folder_type,
        :user => user).save!
      } if Tog::Config["plugins.tog_mail.messages.default_folders"]
    end
  end
end
