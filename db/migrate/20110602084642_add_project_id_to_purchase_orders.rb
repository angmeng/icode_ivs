class AddProjectIdToPurchaseOrders < ActiveRecord::Migration
  def self.up
    add_column :purchase_orders, :project_id, :integer, :default => 0
    add_index :purchase_orders, :project_id
  end

  def self.down
    remove_index :purchase_orders, :project_id
    remove_column :purchase_orders, :project_id
  end
end
