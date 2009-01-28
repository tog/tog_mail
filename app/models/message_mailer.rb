class MessageMailer < ActionMailer::Base

  def email_copy(message)
    @recipients   = message.to.email
    @from         = message.from.email
    @subject      = Tog::Config["plugins.tog_core.mail.default_subject"] + message.subject
    @sent_on      = Time.now
    @content_type = "text/html"
    @body[:from_login] = message.from.login
    @body[:to_login] = message.to.login
    @body[:content] = message.content
  end


end
