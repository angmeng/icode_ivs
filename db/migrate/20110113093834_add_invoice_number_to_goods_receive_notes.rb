class AddInvoiceNumberToGoodsReceiveNotes < ActiveRecord::Migration
  def self.up
    add_column :goods_receive_notes, :invoice_number, :string
    add_column :goods_receive_notes, :serial_number, :string
  end

  def self.down
    remove_column :goods_receive_notes, :invoice_number
    remove_column :goods_receive_notes, :serial_number
  end
end
