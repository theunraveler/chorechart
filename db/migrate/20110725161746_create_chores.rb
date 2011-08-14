class CreateChores < ActiveRecord::Migration
  def self.up
    create_table :chores do |t|
      t.integer :group_id
      t.string :name
      t.text :schedule_yaml, :limit => 4294967295
      t.timestamps
    end
  end

  def self.down
    drop_table :chores
  end
end
