class CreateMaterialGroups < ActiveRecord::Migration
  def self.up
    create_table :material_groups do |t|
      t.string :name, :limit => 45
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :material_groups
  end
end
