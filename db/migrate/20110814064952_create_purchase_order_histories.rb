class CreatePurchaseOrderHistories < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_histories do |t|
      t.integer :history_id
      t.integer :year
      t.string :month, :limit => 20
      t.string :delivery_date, :limit => 45
      t.integer :pr_number
      t.integer :po_number
      t.string :project_code, :limit => 45
      t.date :po_issue_date
      t.string :supplier_code, :limit => 45
      t.string :material_code
      t.string :category, :limit => 45
      t.text :item_description
      t.string :uom, :limit => 45
      t.text :remark
      t.decimal :unit_price, :precision => 12, :scale => 3
      t.integer :qty
      t.string :deliver_to, :limit => 45
      t.string :term
      t.string :product_code, :limit => 45
      t.string :currency, :limit => 20
      t.decimal :currency_unit_price, :precision => 12, :scale => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_histories
  end
end
