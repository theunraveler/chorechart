class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_admin, :boolean, :default => 0, :after => :email
  end

  def self.down
    remove_column :users, :is_admin
  end
end
