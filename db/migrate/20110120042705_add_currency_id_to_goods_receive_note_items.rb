class AddCurrencyIdToGoodsReceiveNoteItems < ActiveRecord::Migration
  def self.up
    add_column :goods_receive_note_items, :currency_id, :integer
    add_index :goods_receive_note_items, :currency_id
  end

  def self.down
    remove_index :goods_receive_note_items, :currency_id
    remove_column :goods_receive_note_items, :currency_id
  end
end
