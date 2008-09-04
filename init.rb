require_plugin 'tog_core'
require_plugin 'tog_user'

Tog::Plugins.settings :tog_mail, "messages.default_folders"   => "Inbox Outbox",
                                 "messages_list.size"         => "10"

Tog::Interface.sections(:member).add "Messages", "/member/messages"   
       
Tog::Plugins.observers << :mail_folders_observer
