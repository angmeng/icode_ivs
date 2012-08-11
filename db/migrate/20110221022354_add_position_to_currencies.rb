class AddPositionToCurrencies < ActiveRecord::Migration
  def self.up
    add_column :currencies, :position, :integer
  end

  def self.down
    remove_column :currencies, :position
  end
end
