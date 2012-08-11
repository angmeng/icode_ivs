class AddProjectIdToPurchaseRequisitions < ActiveRecord::Migration
  def self.up
    add_column :purchase_requisitions, :project_id, :integer
    add_index  :purchase_requisitions, :project_id
    add_column :purchase_requisition_items, :stock_quantity, :integer, :default => 0
    add_column :purchase_requisition_items, :purchase_quantity, :integer, :default => 0
    remove_index :purchase_requisition_items, :project_id
    remove_column :purchase_requisition_items, :project_id
  end

  def self.down
    remove_index  :purchase_requisitions, :project_id
    remove_column :purchase_requisitions, :project_id
    remove_column :purchase_requisition_items, :stock_quantity
    remove_column :purchase_requisition_items, :purchase_quantity
  end
end
