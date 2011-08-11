class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :is_admin, :default => false
      t.boolean :is_editor, :default => false
      t.boolean :is_participant, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
