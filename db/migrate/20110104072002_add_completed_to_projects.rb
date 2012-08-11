class AddCompletedToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :completed, :boolean, :default => false
    add_index :projects, :completed
    remove_index :purchase_requisitions, :supplier_id
    remove_column :purchase_requisitions, :supplier_id
    add_column :purchase_requisition_items, :supplier_id, :integer, :null => false
    add_index :purchase_requisition_items, :supplier_id
    add_column :purchase_requisition_items, :purchase_order_id, :integer, :default => 0
    add_index :purchase_requisition_items, :purchase_order_id
    add_column :purchase_requisitions, :issued_user_id, :integer, :default => 0
    add_index :purchase_requisitions, :issued_user_id
    add_column :purchase_requisitions, :approved_user_id, :integer, :default => 0
    add_index :purchase_requisitions, :approved_user_id
  end

  def self.down
    remove_index :projects, :completed
    remove_column :projects, :completed
  end
end
