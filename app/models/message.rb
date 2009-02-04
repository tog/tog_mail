class Message < ActiveRecord::Base

  belongs_to :folder

  belongs_to :from, :class_name => "User", :foreign_key => "from_user_id"
  belongs_to :to,   :class_name => "User", :foreign_key => "to_user_id"
  
  validates_presence_of :folder
  validates_presence_of :from
  validates_presence_of :to

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
    I18n.l(created_at, :format => :short)
  end
  def dispatch!
    copy = self.clone
    copy.folder = self.from.outbox
    copy.save!
    copy.read!
    
    self.folder = self.to.inbox
    self.save!
    
    MessageMailer.deliver_email_copy(self)
  end
end
