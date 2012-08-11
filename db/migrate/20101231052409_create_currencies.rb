class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name, :limit => 10
      t.string :code, :limit => 10
      t.string :description, :limit => 45

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
