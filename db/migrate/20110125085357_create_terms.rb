class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :name, :limit => 45
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :terms
  end
end