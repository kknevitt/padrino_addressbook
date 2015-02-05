class RenameTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :people, :role, :type
  end

  def self.down
    rename_column :people, :type, :role
  end
end
