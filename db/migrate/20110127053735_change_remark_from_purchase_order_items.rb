class ChangeRemarkFromPurchaseOrderItems < ActiveRecord::Migration
  def self.up
    change_column :purchase_order_items, :remark, :text
  end

  def self.down
  end
end
