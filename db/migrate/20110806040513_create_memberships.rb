class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :is_admin
      t.boolean :is_editor
      t.boolean :is_participant

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
