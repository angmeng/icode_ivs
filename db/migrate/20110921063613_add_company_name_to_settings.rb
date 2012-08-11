class AddCompanyNameToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :company_name, :string
  end

  def self.down
    remove_column :settings, :company_name
  end
end
