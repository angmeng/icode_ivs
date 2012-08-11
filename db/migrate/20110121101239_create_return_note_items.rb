class CreateReturnNoteItems < ActiveRecord::Migration
  def self.up
    create_table :return_note_items do |t|
      t.integer :return_note_id, :default => 0
      t.integer :project_id, :default => 0
      t.integer :product_id, :default => 0
      t.integer :material_id, :default => 0
      t.integer :quantity, :default => 0
      t.string :remark

      t.timestamps
    end
    add_index :return_note_items, :return_note_id
    add_index :return_note_items, :project_id
    add_index :return_note_items, :product_id
    add_index :return_note_items, :material_id
  end

  def self.down
    drop_table :return_note_items
  end
end
