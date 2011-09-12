class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :chore_id, :unsigned => true, :null => false
      t.integer :user_id, :unsigned => true, :null => false
      t.date :date, :null => false
      t.boolean :is_complete, :default => false
      t.timestamps
    end
    change_table :assignments do |t|
      t.foreign_key :chores, :dependent => :delete
      t.foreign_key :users, :dependent => :delete
    end
  end

  def self.down
    drop_table :assignments
  end
end
