class CreateReservedPurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :reserved_purchase_orders do |t|
      t.string :purchase_order_number, :limit => 10
      t.integer :purchase_order_id, :default => 0
      t.boolean :used, :default => false
      t.text :remark

      t.timestamps
    end
    add_index :reserved_purchase_orders, :purchase_order_id
  end

  def self.down
    drop_table :reserved_purchase_orders
  end
end
