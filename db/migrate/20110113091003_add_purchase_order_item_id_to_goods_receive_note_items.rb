class AddPurchaseOrderItemIdToGoodsReceiveNoteItems < ActiveRecord::Migration
  def self.up
    add_column :goods_receive_note_items, :purchase_order_item_id, :integer, :null => false
    add_column :goods_receive_note_items, :deliver_quantity, :integer, :default => 0
    add_column :goods_receive_note_items, :settled, :boolean, :default => false
    add_index :goods_receive_note_items, :purchase_order_item_id
    add_index :goods_receive_note_items, :settled
  end

  def self.down
    remove_index :goods_receive_note_items, :purchase_order_item_id
    remove_index :goods_receive_note_items, :settled
    remove_column :goods_receive_note_items, :purchase_order_item_id
    remove_column :goods_receive_note_items, :deliver_quantity
    remove_column :goods_receive_note_items, :settled
  end
end
