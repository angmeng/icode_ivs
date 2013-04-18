class AddKgToMaterials < ActiveRecord::Migration
  def self.up
    add_column :materials, :kg, :decimal, :precision => 19, :scale => 3, :default => 0.000
  end

  def self.down
    remove_column :materials, :kg
  end
end
