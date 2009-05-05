class Folder < ActiveRecord::Base    
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :user
  
  has_many :messages, :order => "created_at DESC", :dependent => :destroy


  def siblings
    owner.folders
  end
  def has_no_messages 
    messages.size == 0
  end
end
