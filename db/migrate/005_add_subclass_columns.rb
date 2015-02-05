class AddSubclassColumns < ActiveRecord::Migration
  def self.up
    add_column :people, :favourite_language, :string
    add_column :people, :years_experience, :integer
    add_column :people, :favourite_meal, :string
    add_column :people, :position_table_tennis_ladder, :integer
  end

  def self.down
    remove_column :people, :favourite_language
    remove_column :people, :years_experience
    remove_column :people, :favourite_meal
    remove_column :people, :position_table_tennis_ladder
  end
end
