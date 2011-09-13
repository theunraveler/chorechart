class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.timestamps
    end
    change_table :authentications do |t|
      t.foreign_key :users, :dependent => :delete
    end
  end

  def self.down
    drop_table :authentications
  end
end
