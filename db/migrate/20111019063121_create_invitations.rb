class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.string :email
      t.integer :group_id
      t.string :role

      t.timestamps
    end

    add_foreign_key(:invitations, :groups, :dependent => :delete)    
    add_index :invitations, :email
    add_index :invitations, :group_id
    add_index :invitations, [:group_id, :email]
  end

  def self.down
    drop_table :invitations
  end
end
