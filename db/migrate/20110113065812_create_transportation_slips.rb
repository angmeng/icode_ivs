class CreateTransportationSlips < ActiveRecord::Migration
  def self.up
    create_table :transportation_slips do |t|
      t.date :transport_date
      t.integer :project_id, :default => 0
      t.integer :supplier_id, :null => false
      t.integer :vehicle_id, :null => false
      t.string :lorry_number, :limit => 20
      t.string :description_of_goods
      t.integer :quantity, :default => 0
      t.string :from_location, :limit => 45
      t.string :to_location, :limit => 45
      t.string :driver_name, :limit => 45
      t.string :driver_ic, :limit => 20
      t.string :checked_by, :limit => 45
      t.string :do_number, :limit => 45
      t.decimal :fee, :precision => 10, :scale => 2, :default => 0.00

      t.timestamps
    end
  end

  def self.down
    drop_table :transportation_slips
  end
end
