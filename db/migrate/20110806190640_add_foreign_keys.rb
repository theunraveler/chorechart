class AddForeignKeys < ActiveRecord::Migration
  def self.up
    change_table :memberships do |t|
      t.foreign_key :groups, :dependent => :delete
      t.foreign_key :users, :dependent => :delete
    end
    change_table :chores do |t|
      t.foreign_key :groups, :dependent => :delete
    end
  end

  def self.down
    change_table :memberships do |t|
      t.remove_foreign_key :groups
      t.remove_foreign_key :users
    end
    change_table :chores do |t|
      t.remove_foreign_key :groups
    end
  end
end
