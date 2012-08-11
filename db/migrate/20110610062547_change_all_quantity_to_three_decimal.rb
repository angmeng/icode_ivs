class ChangeAllQuantityToThreeDecimal < ActiveRecord::Migration
  def self.up
    change_column :goods_receive_note_items, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :goods_receive_note_items, :deliver_quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :invoice_items, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :purchase_order_items, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :purchase_requisition_items, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :purchase_requisition_items, :stock_quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :purchase_requisition_items, :purchase_quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :return_note_items, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :stock_adjustments, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :transportation_slips, :quantity, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :transportation_slips, :fee, :decimal, :precision => 12, :scale => 3, :default => 0.000
  end

  def self.down
  end
end
