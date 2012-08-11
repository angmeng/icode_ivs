class CreateMaterials < ActiveRecord::Migration
  def self.up
    create_table :materials do |t|
      t.string :code, :limit => 45
      t.integer :material_group_id
      t.integer :material_category_id
      t.string :description
      t.integer :uom_id
      t.text :remark

      t.timestamps
    end
    add_index :materials, :material_group_id
    add_index :materials, :material_category_id
    add_index :materials, :uom_id
  end

  def self.down
    drop_table :materials
  end
end
