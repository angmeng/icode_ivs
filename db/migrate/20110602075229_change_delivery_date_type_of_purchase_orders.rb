class ChangeDeliveryDateTypeOfPurchaseOrders < ActiveRecord::Migration
  def self.up
    change_column :purchase_orders, :delivery_date, :string, :limit => 45
    change_column :purchase_requisitions, :delivery_date, :string, :limit => 45
  end

  def self.down
  end
end
