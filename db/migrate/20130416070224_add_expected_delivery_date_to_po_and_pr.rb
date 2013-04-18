class AddExpectedDeliveryDateToPoAndPr < ActiveRecord::Migration
  def self.up
  	add_column :purchase_requisitions, :expected_delivery_date, :date
  	add_column :purchase_orders, :expected_delivery_date, :date
  end

  def self.down
  	remove_column :purchase_requisitions, :expected_delivery_date
  	remove_column :purchase_orders, :expected_delivery_date
  end
end
