class ChangeAllDecimalToThreeScale < ActiveRecord::Migration
  def self.up
    change_column :customer_pricings, :amount, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :goods_receive_note_items, :unit_price, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :invoice_items, :commission, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :purchase_order_items, :unit_price, :decimal, :precision => 12, :scale => 3, :default => 0.000
    change_column :purchase_requisition_items, :unit_price, :decimal, :precision => 12, :scale => 3, :default => 0.000
  end

  def self.down
  end
end
