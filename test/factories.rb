Factory.define :user do |u|
  u.salt '7e3041ebc2fc05a40c60028e2c4901a81035d3cd'
  u.crypted_password '00742970dc9e6319f8019fd54864d3ea740f04b1'
  u.activation_code '8f24789ae988411ccf33ab0c30fe9106fab32e9a'
  u.state 'pending'
  u.email {|a| "#{a.login}@example.com".downcase }
end

Factory.define :message do |u|
end

Factory.define :inbox, :class => Folder do |u|
  u.folder_type 'Inbox'
end

Factory.define :outbox, :class => Folder do |u|
  u.folder_type 'Outbox'
end

Factory.define :folder do |u|
end

