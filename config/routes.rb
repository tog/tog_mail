# Add your custom routes here.  If in config/routes.rb you would 
# add <tt>map.resources</tt>, here you would add just <tt>resources</tt>

# resources :tog_mails


namespace(:member) do |member|

  member.with_options(:controller => 'messages') do |messages|
    messages.resources :messages,
      :collection => { :move => :post,
                       :copy => :post,
                       :mark_as_read => :post,
                       :mark_as_unread => :post,
                       :search => :get
                     },
      :member => { :reply => :get }
    messages.new_message_to 'messages/new/:user_id', :action => "new"
  end

end