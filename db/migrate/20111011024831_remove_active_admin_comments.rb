class RemoveActiveAdminComments < ActiveRecord::Migration
  def self.up
    drop_table :active_admin_comments
  end

  def self.down
  end
end
