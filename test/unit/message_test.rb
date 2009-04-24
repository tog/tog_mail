require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < ActiveSupport::TestCase
  context "A Message" do

    setup do
      @obama = Factory(:user, :login => 'obama')
      @bush  = Factory(:user, :login => 'bush')
      @outbox = Factory(:outbox, :user => @obama)
      @inbox  = Factory(:inbox, :user => @bush)
      
      @msg = Message.new(:from => @obama,:to => @bush, :subject => "The time has come.", :content => "Get out my house you asshole!")
    end
    
    context "that is dispatched" do
      setup do
        @msg.dispatch!
      end
    
      should "left a copy on sender's outbox" do
         assert_equal @outbox.messages.first.subject, "The time has come."
      end

      should "left the message on receiver's inbox" do
        assert_contains @inbox.messages, @msg
      end
    
      should "send a real email copy to the receiver" do
        assert_sent_email do |email|
          email.to.include? @bush.email
          email.from.include? @obama.email
          email.subject.include?("The time has come.")
        end
      end
    
    end
  end

end
