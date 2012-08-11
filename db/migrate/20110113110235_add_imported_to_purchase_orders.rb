class AddImportedToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :imported, :boolean, :default => false
    add_index :purchase_orders, :imported
  end

  def self.down
    remove_index :purchase_orders, :imported
    remove_column :purchase_orders, :imported
  end
end
