class CreateTogMailTables < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.string   :name
      t.integer  :user_id
      t.boolean  :deletable,    :default => false
      t.string   :folder_type
      t.integer  :lock_version, :default => 0
      t.timestamps
    end
    create_table :messages do |t|
      t.string   :subject
      t.text     :content
      t.integer  :folder_id
      t.boolean  :is_read,    :default => false
      t.integer  :from_user_id
      t.integer  :to_user_id
      t.timestamps
    end
    create_table :message_readings do |t|
      t.integer  :message_id
      t.integer  :user_id
      t.datetime :read_at
      t.timestamps
    end

  end

  def self.down
    drop_table :folders
    drop_table :messages
    drop_table :message_readings
  end
end
