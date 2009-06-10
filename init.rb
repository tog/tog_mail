require_plugin 'tog_core'

require "i18n" unless defined?(I18n)
Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

Tog::Plugins.settings :tog_mail, "messages.default_folders"   => "Inbox Outbox",
                                 "messages_list.size"         => "10"

Tog::Interface.sections(:member).add "Messages", "/member/messages"