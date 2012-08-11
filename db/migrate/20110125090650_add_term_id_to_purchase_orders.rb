class AddTermIdToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :term_id, :integer, :default => 0
    add_index :purchase_orders, :term_id
  end

  def self.down
    remove_index :purchase_orders, :term_id
    remove_column :purchase_orders, :term_id
  end
end
