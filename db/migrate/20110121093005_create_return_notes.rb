class CreateReturnNotes < ActiveRecord::Migration
  def self.up
    create_table :return_notes do |t|
      t.string :grn_number, :limit => 20
      t.date :grn_date
      t.integer :supplier_id, :default => 0, :null => false
      t.integer :do_number, :limit => 45
      t.string :serial_number, :limit => 45
      t.string :invoice_number, :limit => 45
      t.string :remark
      t.boolean :void, :default => false
      t.boolean :settled, :default => false

      t.timestamps
    end
    add_index :return_notes, :supplier_id
  end

  def self.down
    drop_table :return_notes
  end
end
