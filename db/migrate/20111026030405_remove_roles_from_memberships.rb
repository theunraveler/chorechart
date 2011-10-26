class RemoveRolesFromMemberships < ActiveRecord::Migration
  def self.up
    remove_column :memberships, :is_editor
    remove_column :memberships, :is_participant
  end

  def self.down
    add_column :memberships, :is_editor, :boolean, :default => false, :after => :is_admin
    add_column :memberships, :is_participant, :boolean, :default => false, :after => :is_editor
  end
end
