Edge
----

0.4.4
----

0.4.3
----

0.4.2
----
* Ticket #118. i18n in navigation tabs
* Every internal message should send a regular email copy to the recipient.
* Error sending message without selecting target user [#127 status:resolved]

0.4.0
----
* Ticket #111. undefined method `white_list_sanitizer' for Member::MessagesController:Class
* Only pending users should be displayed on the profiles section
* removed record_activity from models, not public information/of any interest in most scenarios
* some usage information

0.3.0
----
* MailUserObserver refactored to call user.create_default_folders!
* Create the default folders for every user on the migration.