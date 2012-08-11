class AddFromAddressToTransportationSlips < ActiveRecord::Migration
  def self.up
    add_column :transportation_slips, :from_address, :text
    add_column :transportation_slips, :to_address, :text
  end

  def self.down
    remove_column :transportation_slips, :from_address
    remove_column :transportation_slips, :to_address
  end
end
