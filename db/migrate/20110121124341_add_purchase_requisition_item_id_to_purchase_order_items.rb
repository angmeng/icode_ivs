class AddPurchaseRequisitionItemIdToPurchaseOrderItems < ActiveRecord::Migration
  def self.up
    add_column :purchase_order_items, :purchase_requisition_item_id, :integer, :default => 0
    add_index :purchase_order_items, :purchase_requisition_item_id
  end

  def self.down
    remove_index :purchase_order_items, :purchase_requisition_item_id
    remove_column :purchase_order_items, :purchase_requisition_item_id
  end
end
