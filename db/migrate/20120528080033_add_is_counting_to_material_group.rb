class AddIsCountingToMaterialGroup < ActiveRecord::Migration
  def self.up
    add_column :material_groups, :is_counting, :boolean, :default => false
    add_index  :material_groups, :is_counting
  end

  def self.down
    remove_index  :material_groups, :is_counting
    remove_column :material_groups, :is_counting
  end
end
