class ChangeSupplierEmailLength < ActiveRecord::Migration
  def self.up
    change_column :suppliers, :email, :string, :limit => 45
  end

  def self.down
  end
end
