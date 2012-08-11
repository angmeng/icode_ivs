class AddDeliveryDateToPurchaseOrdersAndPrs < ActiveRecord::Migration
  def self.up
    add_column :purchase_requisitions, :delivery_date, :date
    add_column :purchase_orders, :delivery_date, :date
  end

  def self.down
    remove_column :purchase_requisitions, :delivery_date
    remove_column :purchase_orders, :delivery_date
  end
end
