class User < ActiveRecord::Base
  
  has_one :inbox, :class_name => "Folder", :foreign_key => "user_id", :conditions => ["folder_type = 'Inbox'"]
  has_one :outbox, :class_name => "Folder", :foreign_key => "user_id", :conditions => ["folder_type = 'Outbox'"]

  has_many :folders
  has_many :sent_messages, :class_name => "Message", :foreign_key => "from_user_id"
  has_many :received_messages, :class_name => "Message", :foreign_key => "to_user_id"
  def messages
    sent_messages + received_messages
  end
  
end
