class Message < ActiveRecord::Base

  belongs_to :folder

  belongs_to :from, :class_name => "User", :foreign_key => "from_user_id"
  belongs_to :to,   :class_name => "User", :foreign_key => "to_user_id"
  
  validates_presence_of :folder
  validates_presence_of :from
  validates_presence_of :to

  record_activity_of :from_user
  acts_as_abusable
  
  def read!
    update_attribute(:is_read, true)
  end
  def read?
    is_read?
  end

  def unread!
    update_attribute(:is_read, false)
  end
  def unread?
    !read?
  end

  def date
    created_at.strftime("%d/%m/%Y %H:%M")
  end
  def dispatch!
    copy = self.clone
    copy.folder = self.from.outbox
    copy.save!
    copy.read!
    
    self.folder = self.to.inbox
    self.save!
  end
end