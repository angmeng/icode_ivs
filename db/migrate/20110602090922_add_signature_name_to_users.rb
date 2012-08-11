class AddSignatureNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :signature_name, :string, :limit => 45
  end

  def self.down
    remove_column :users, :signature_name
  end
end
