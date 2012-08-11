class AddCurrencyIdToPurchaseRequisitionItems < ActiveRecord::Migration
  def self.up
    add_column :purchase_requisition_items, :currency_id, :integer
    add_index :purchase_requisition_items, :currency_id
    add_column :purchase_order_items, :currency_id, :integer
    add_index :purchase_order_items, :currency_id
  end

  def self.down
    remove_index :purchase_requisition_items, :currency_id
    remove_column :purchase_requisition_items, :currency_id
    remove_index :purchase_order_items, :currency_id
    remove_column :purchase_order_items, :currency_id
  end
end
