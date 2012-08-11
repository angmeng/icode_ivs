class AddDeliverToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :deliver_to, :string, :limit => 45
  end

  def self.down
    remove_column :purchase_orders, :deliver_to
  end
end
