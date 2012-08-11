class AddSequenceNumberToPurchaseRequisitionItems < ActiveRecord::Migration
  def self.up
    add_column :purchase_requisition_items, :sequence_number, :integer, :default => 0
  end

  def self.down
    remove_column :purchase_requisition_items, :sequence_number
  end
end
