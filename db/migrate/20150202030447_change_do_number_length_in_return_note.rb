class ChangeDoNumberLengthInReturnNote < ActiveRecord::Migration
  def self.up
  	change_column :return_notes, :do_number, :limit => 255
  	change_column :return_notes, :invoice_number, :limit => 255
  end

  def self.down
  end
end
