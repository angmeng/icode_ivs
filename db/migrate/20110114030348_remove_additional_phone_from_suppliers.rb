class RemoveAdditionalPhoneFromSuppliers < ActiveRecord::Migration
  def self.up
    remove_column(:suppliers, :additional_phone_one)
    rename_column(:suppliers, :additional_phone_two, :email)
  end

  def self.down
  end
end
