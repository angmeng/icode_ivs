class CreatePurchaseRequisitionCategories < ActiveRecord::Migration
  def self.up
    create_table :purchase_requisition_categories do |t|
      t.string :name, :limit => 45
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_requisition_categories
  end
end
