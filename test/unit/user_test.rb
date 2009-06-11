require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  context "A user" do

    setup do
      @obama = Factory(:user, :login => 'obama')
      @bush  = Factory(:user, :login => 'bush')

      @outbox_obama = Factory(:outbox, :user => @obama)
      @inbox_obama  = Factory(:inbox, :user => @obama)

      @outbox_bush = Factory(:outbox, :user => @bush)
      @inbox_bush  = Factory(:inbox, :user => @bush)
      
      @msg = Message.new(:from => @obama,:to => @bush, :subject => "The time has come.", :content => "Get out my house you asshole!")
      @msg.dispatch!

      @msg = Message.new(:from => @bush,:to => @obama, :subject => "No without fight!.", :content => "Hahaha!")
      @msg.dispatch!
    end
    
    context "that is destroyed" do
      setup do
        @bush.destroy
      end
    
      should "have his folders removed" do
         assert Folder.find(:all, :conditions => {:user_id => @bush.id}).size, 0 
      end

      should "have his messages removed" do
        assert Message.find(:all, :conditions => {:from_user_id => @bush.id, :to_user_id => @bush.id}).size, 0 
      end
        
    end
  end

end