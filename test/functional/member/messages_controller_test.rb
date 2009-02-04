require File.dirname(__FILE__) + '/../../test_helper'

class Member::MessagesControllerTest < ActionController::TestCase
  context "A logged user" do
    setup do
      @berlusconi = Factory(:user, :login => 'berlusconi')
      @berlusconi.activate!

      @chavez = Factory(:user, :login => 'chavez')
      @chavez.activate!

      @request.session[:user_id]= @berlusconi.id
    end

    context "on POST to :create" do
      context "to valid user" do
        setup do
          post :create, {:message => {:to_user_id => @chavez.id, :subject => "See you later!", :content => "bla, bla, bla..."}}
        end

        should "send a message" do
          assert_equal 1, @chavez.inbox.messages.count
          assert_equal "See you later!", @chavez.inbox.messages.first.subject
        end

        should_set_the_flash_to I18n.t("tog_mail.member.message_sent")
      end

      context "to invalid user" do
        setup do
          post :create, {:message => {:subject => "See you later!", :content => "bla, bla, bla..."}}
        end

        should "not send a message" do
          assert_equal 0, @chavez.inbox.messages.count
        end

        should_set_the_flash_to I18n.t("tog_mail.member.user_not_found")
        should_render_template :new
      end
    end
  end
end