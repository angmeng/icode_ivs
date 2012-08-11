class ChangeTermDatatypeOfPurchaseOrders < ActiveRecord::Migration
  def self.up
    change_column :purchase_orders, :term_id, :string, :limit => 45
    rename_column(:purchase_orders, :term_id, :term)
  end

  def self.down
  end
end
