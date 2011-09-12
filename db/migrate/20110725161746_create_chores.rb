class CreateChores < ActiveRecord::Migration
  def self.up
    create_table :chores do |t|
      t.integer :group_id, :unsigned => true, :null => false
      t.string :name, :null => false
      t.integer :difficulty, :unsigned => true, :null => false
      t.text :schedule_yaml, :limit => 4294967295
      t.timestamps
    end
  end

  def self.down
    drop_table :chores
  end
end
