class User < ActiveRecord::Base

  has_one :inbox, :class_name => "Folder", :foreign_key => "user_id", :conditions => ["folder_type = 'Inbox'"]
  has_one :outbox, :class_name => "Folder", :foreign_key => "user_id", :conditions => ["folder_type = 'Outbox'"]

  has_many :folders
  has_many :sent_messages, :class_name => "Message", :foreign_key => "from_user_id"
  has_many :received_messages, :class_name => "Message", :foreign_key => "to_user_id"

  def get_message(id)
    begin
    sent_messages.find(id)
    rescue
      received_messages.find(id)
    end
  end

  def create_default_folders!
    default_folders = Tog::Config["plugins.tog_mail.messages.default_folders"] || ""
    default_folders.each(" "){|folder_type|
      folder_type.strip!
      unless self.folders.find_by_name(folder_type)
        self.folders.create(:name => folder_type, :deletable => false, :folder_type => folder_type)
      end
    }
  end

end
