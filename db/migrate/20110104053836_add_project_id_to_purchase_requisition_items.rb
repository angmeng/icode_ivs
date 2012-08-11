class AddProjectIdToPurchaseRequisitionItems < ActiveRecord::Migration
  def self.up
    add_column :purchase_requisition_items, :project_id, :integer, :default => 0
    add_column :purchase_requisition_items, :material_id, :integer, :null => false
    add_column :purchase_order_items, :project_id, :integer, :default => 0
    add_column :purchase_order_items, :material_id, :integer, :null => false
    add_column :goods_receive_note_items, :project_id, :integer, :default => 0
    add_column :goods_receive_note_items, :material_id, :integer, :null => false
    add_index :purchase_requisition_items, :project_id
    add_index :purchase_requisition_items, :material_id
    add_index :purchase_order_items, :project_id
    add_index :purchase_order_items, :material_id
    add_index :goods_receive_note_items, :project_id
    add_index :goods_receive_note_items, :material_id
  end

  def self.down
    remove_column :purchase_requisition_items, :project_id
    remove_column :purchase_requisition_items, :material_id, :integer, :null => false
    remove_column :purchase_order_items, :project_id, :integer, :default => 0
    remove_column :purchase_order_items, :material_id, :integer, :null => false
    remove_column :goods_receive_note_items, :project_id, :integer, :default => 0
    remove_column :goods_receive_note_items, :material_id, :integer, :null => false
    remove_index :purchase_requisition_items, :project_id
    remove_index :purchase_requisition_items, :material_id
    remove_index :purchase_order_items, :project_id
    remove_index :purchase_order_items, :material_id
    remove_index :goods_receive_note_items, :project_id
    remove_index :goods_receive_note_items, :material_id
  end
end
