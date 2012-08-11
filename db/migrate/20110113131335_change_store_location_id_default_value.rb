class ChangeStoreLocationIdDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :goods_receive_note_items, :store_location_id, :integer, :default => 0
  end

  def self.down
  end
end
