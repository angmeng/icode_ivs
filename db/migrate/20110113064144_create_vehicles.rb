class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.string :name, :limit => 45
      t.string :description
      t.boolean :disabled, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
