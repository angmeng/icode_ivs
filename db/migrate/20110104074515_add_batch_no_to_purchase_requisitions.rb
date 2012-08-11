class AddBatchNoToPurchaseRequisitions < ActiveRecord::Migration
  def self.up
    add_column :purchase_requisitions, :batch_no, :string, :limit => 45
    add_column :purchase_requisitions, :purchase_requisition_category_id, :integer, :null => false
    add_index :purchase_requisitions, :purchase_requisition_category_id
  end

  def self.down
    remove_column :purchase_requisitions, :batch_no
    remove_index :purchase_requisitions, :purchase_requisition_category_id
    remove_column :purchase_requisitions, :purchase_requisition_category_id

  end
end
