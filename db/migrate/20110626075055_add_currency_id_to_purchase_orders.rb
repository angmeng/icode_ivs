class AddCurrencyIdToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :currency_id, :integer, :default => 1
    add_column :purchase_requisitions, :currency_id, :integer, :default => 1
    add_index :purchase_orders, :currency_id
    add_index :purchase_requisitions
  end

  def self.down
    remove_column :purchase_orders, :currency_id
    remove_column :purchase_requisitions, :currency_id
  end
end
