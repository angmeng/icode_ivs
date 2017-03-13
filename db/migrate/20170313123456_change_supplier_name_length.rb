class ChangeSupplierNameLength < ActiveRecord::Migration
  def self.up
  	change_column :suppliers, :name, :limit => 255
  end

  def self.down
  end
end
