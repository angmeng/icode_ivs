class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :code, :limit => 45
      t.string :name
      t.string :description
      t.string :address, :limit => 45
      t.integer :user_id, :default => 0

      t.timestamps
    end
    add_index :projects, :user_id
  end

  def self.down
    drop_table :projects
  end
end
