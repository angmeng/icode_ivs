class AddPurchaseOrderItemIdToReturnNoteItems < ActiveRecord::Migration
  def self.up
    add_column :return_note_items, :purchase_order_item_id, :integer, :default => 0
    add_index :return_note_items, :purchase_order_item_id
  end

  def self.down
  	remove_index :return_note_items, :purchase_order_item_id
    remove_column :return_note_items, :purchase_order_item_id
  end
end
