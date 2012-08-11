class AddPurchaseOrderIdToGoodsReceiveNotes < ActiveRecord::Migration
  def self.up
    add_column :goods_receive_notes, :purchase_order_id, :integer, :null => false
    add_column :goods_receive_notes, :do_number, :string
    add_index :goods_receive_notes, :purchase_order_id
  end

  def self.down
    remove_index :goods_receive_notes, :purchase_order_id
    remove_column :goods_receive_notes, :purchase_order_id
    remove_column :goods_receive_notes, :do_number, :string
  end
end
