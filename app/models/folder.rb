class Folder < ActiveRecord::Base    
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
  belongs_to :user
  
  has_many :messages, :order => "created_at DESC" do
    def unread
     find(:all, :conditions => ["is_read = ?", false])
    end
    def read
     find(:all, :conditions => ["is_read = ?", true])
    end
  end

  def siblings
    owner.folders
  end
  def has_no_messages 
    messages.size == 0
  end
end
