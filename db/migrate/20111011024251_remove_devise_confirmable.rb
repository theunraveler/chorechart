class RemoveDeviseConfirmable < ActiveRecord::Migration
  def self.up
    remove_index :users, :confirmation_token
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
  end

  def self.down
    # Sigh
  end
end
