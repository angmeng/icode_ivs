class AddPurchasedUserIdToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :purchased_user_id, :integer, :default => 0
    add_column :purchase_orders, :approved_user_id, :integer, :default => 0
    add_index :purchase_orders, :purchased_user_id
    add_index :purchase_orders, :approved_user_id
  end

  def self.down
    remove_index :purchase_orders, :purchased_user_id
    remove_index :purchase_orders, :approved_user_id
    remove_column :purchase_orders, :purchased_user_id
    remove_column :purchase_orders, :approved_user_id
  end
end
