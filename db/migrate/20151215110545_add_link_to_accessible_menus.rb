class AddLinkToAccessibleMenus < ActiveRecord::Migration
  def self.up
    add_column :accessible_menus, :link, :string, :default => "/"
  end

  def self.down
    remove_column :accessible_menus, :link
  end
end
