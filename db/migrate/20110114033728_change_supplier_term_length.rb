class ChangeSupplierTermLength < ActiveRecord::Migration
  def self.up
    change_column :suppliers, :term, :string, :limit => 255
  end

  def self.down
  end
end
